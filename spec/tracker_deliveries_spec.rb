require 'spec_helper'
require 'ostruct'

include TrackerDeliveries

describe TrackerDeliveries do
  before do
    @project_id = 'PROJECT ID'
    @api_token = 'API TOKEN'
    ENV['TRACKER_DELIVERIES_PROJECT_ID'] = @project_id
    ENV['TRACKER_DELIVERIES_API_TOKEN'] = @api_token
  end

  it 'has a version number' do
    expect(TrackerDeliveries::VERSION).not_to be nil
  end

  describe Main do
    it 'is an instance of TrackerDeliveries::Main' do
      expect(subject).to be_instance_of TrackerDeliveries::Main
    end

    it 'reads project id from environment' do
      expect(subject.project_id).to eq @project_id
    end

    it 'reads api token from environment' do
      expect(subject.api_token).to eq @api_token
    end

    it 'has a pivotal tracker api wrapper' do
      expect(subject.pivotal_tracker).to be_instance_of PivotalTracker
    end

    it 'get list of delivered stories' do
      pivotal_tracker = double("pivotal tracker")

      allow(pivotal_tracker)
        .to receive(:delivered_stories)

      expect(pivotal_tracker)
        .to receive(:delivered_stories)

      tracker_deliveries = TrackerDeliveries::Main.new
      tracker_deliveries.pivotal_tracker = pivotal_tracker

      tracker_deliveries.delivered_stories
    end
  end
end

describe PivotalTracker do
  it 'requests delivered stories from pivotal tracker (via blanket wrapper)' do
    pivotal_tracker = PivotalTracker.new @project_id, @api_token

    story_one = OpenStruct.new({id: '#123456', name: 'Story one'})
    story_two = OpenStruct.new({id: '#654321', name: 'Story two'})

    blanket = double 'Blanket'
    projects = double 'Projects'
    stories = double 'Stories'
    get = double 'Get'
    options = { with_state: 'delivered' }

    allow(blanket).to receive(:projects)
                        .with(@project_id)
                        .and_return(projects)

    allow(projects).to receive(:stories)
                         .and_return(stories)

    allow(stories).to receive(:get)
                        .with({ params: options })
                        .and_return(get)

    allow(get).to receive(:payload)
                    .and_return([
                                  story_one,
                                  story_two
                                ])

    pivotal_tracker.api = blanket

    result = pivotal_tracker.delivered_stories

    expect(result).to eq [
                        '#123456 - Story one',
                        '#654321 - Story two'
                      ]
  end
end
