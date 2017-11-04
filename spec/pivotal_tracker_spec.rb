require 'spec_helper'
require 'ostruct'

include TrackerDeliveries

describe PivotalTracker do

  let(:project_id)      { '12313131' }
  let(:api_token)       { '_token_' }
  let(:subject)         { PivotalTracker.new(project_id, api_token) }
  let(:story_one)       { OpenStruct.new({id: '123456', name: 'Story one'}) }
  let(:story_two)       { OpenStruct.new({id: '654321', name: 'Story two'}) }
  let(:blanket)         { double 'Blanket' }
  let(:projects)        { double 'Projects' }
  let(:stories)         { double 'Stories' }
  let(:get)             { double 'Get' }
  let(:options)         { { with_state: 'delivered' } }
  let(:result)          { subject.delivered_stories }

  before do
    allow(blanket).to receive(:projects).with(project_id).and_return(projects)
    allow(projects).to receive(:stories).and_return(stories)
    allow(stories).to receive(:get).with({ params: options }).and_return(get)
    allow(get).to receive(:payload).and_return([story_one,story_two])

    subject.api = blanket
  end

  context "plaintext output" do
    it 'output delivered stories from pivotal tracker in plaintext format' do
      expect(result).to eq(%Q{123456 - Story one\n654321 - Story two})
    end
  end

  context "markdown output" do
    let(:subject) { PivotalTracker.new(project_id, api_token, format: :markdown) }

    it 'output delivered stories from pivotal tracker in markdown format' do
      expect(result).to eq(%Q{- [123456](https://pivotaltracker.com/story/show/123456) - Story one\n- [654321](https://pivotaltracker.com/story/show/654321) - Story two})
    end
  end

  context "HTML output" do
    let(:subject) { PivotalTracker.new(project_id, api_token, format: :html) }

    it 'output delivered stories from pivotal tracker in HTML format' do
      expect(result).to eq(%Q{<ul>
<li><a href="https://pivotaltracker.com/story/show/123456">123456</a> - Story one</li>
<li><a href="https://pivotaltracker.com/story/show/654321">654321</a> - Story two</li>
</ul>})
    end
  end

end
