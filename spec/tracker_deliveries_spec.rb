require 'spec_helper'
require 'ostruct'

include TrackerDeliveries

describe TrackerDeliveries do
  let(:project_id) { 'PROJECT ID' }
  let(:api_token)  { 'API TOKEN' }

  context 'environment not correctly set up' do
    it 'raises an error when the project id environment variable TRACKER_DELIVERIES_PROJECT_ID is not set' do
      ENV['TRACKER_DELIVERIES_PROJECT_ID'] = nil
      ENV['TRACKER_DELIVERIES_API_TOKEN'] = api_token
      expect{ TrackerDeliveries::Main.new }.to raise_error SystemExit
    end

    it 'raises an error when the project id environment variable TRACKER_DELIVERIES_API_TOKEN is not set' do
      ENV['TRACKER_DELIVERIES_PROJECT_ID'] = project_id
      ENV['TRACKER_DELIVERIES_API_TOKEN'] = nil
      expect{ TrackerDeliveries::Main.new }.to raise_error SystemExit
    end
  end

  before do
    ENV['TRACKER_DELIVERIES_PROJECT_ID'] = project_id
    ENV['TRACKER_DELIVERIES_API_TOKEN'] = api_token
  end

  it 'has a version number' do
    expect(TrackerDeliveries::VERSION).not_to be nil
  end

  describe Main do
    it 'is an instance of TrackerDeliveries::Main' do
      expect(subject).to be_instance_of TrackerDeliveries::Main
    end

    it 'reads project id from environment' do
      expect(subject.project_id).to eq project_id
    end

    it 'reads api token from environment' do
      expect(subject.api_token).to eq api_token
    end

    context "Depend on pivotal tracker api wrapper" do
      let(:pivotal_tracker) { double("pivotal tracker") }
      let(:tracker_deliveries) { TrackerDeliveries::Main.new }

      it 'has a pivotal tracker api wrapper' do
        expect(subject.pivotal_tracker).to be_instance_of PivotalTracker
      end

      it 'get list of delivered stories' do
        allow(pivotal_tracker).to receive(:delivered_stories)
        expect(pivotal_tracker).to receive(:delivered_stories)

        tracker_deliveries.pivotal_tracker = pivotal_tracker

        tracker_deliveries.delivered_stories
      end
    end
  end

  describe PivotalTracker do

    let(:pivotal_tracker) { PivotalTracker.new(project_id, api_token) }
    let(:story_one)       { OpenStruct.new({id: '123456', name: 'Story one'}) }
    let(:story_two)       { OpenStruct.new({id: '654321', name: 'Story two'}) }
    let(:blanket)         { double 'Blanket' }
    let(:projects)        { double 'Projects' }
    let(:stories)         { double 'Stories' }
    let(:get)             { double 'Get' }
    let(:options)         { { with_state: 'delivered' } }
    let(:result)          { pivotal_tracker.delivered_stories }

    before do
      allow(blanket).to receive(:projects).with(project_id).and_return(projects)
      allow(projects).to receive(:stories).and_return(stories)
      allow(stories).to receive(:get).with({ params: options }).and_return(get)
      allow(get).to receive(:payload).and_return([story_one,story_two])

      pivotal_tracker.api = blanket
    end

    context "plaintext output" do
      it 'output delivered stories from pivotal tracker in plaintext format' do
        expect(result).to eq(%Q{123456 - Story one\n654321 - Story two})
      end
    end

    context "markdown output" do
      let(:pivotal_tracker) { PivotalTracker.new(project_id, api_token, format: :markdown) }

      it 'output delivered stories from pivotal tracker in markdown format' do
        expect(result).to eq(%Q{- [123456](https://pivotaltracker.com/story/show/123456) - Story one\n- [654321](https://pivotaltracker.com/story/show/654321) - Story two})
      end
    end

    context "HTML output" do
      let(:pivotal_tracker) { PivotalTracker.new(project_id, api_token, format: :html) }

      it 'output delivered stories from pivotal tracker in HTML format' do
        expect(result).to eq(%Q{<ul>
<li><a href="https://pivotaltracker.com/story/show/123456">123456</a> - Story one</li>
<li><a href="https://pivotaltracker.com/story/show/654321">654321</a> - Story two</li>
</ul>})
      end
    end

  end
end
