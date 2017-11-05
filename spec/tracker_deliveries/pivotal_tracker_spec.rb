require 'spec_helper'
require 'ostruct'

include TrackerDeliveries

describe PivotalTracker do
  let(:story_url)       { "https://pivotaltracker.com/story/show/" }
  let(:project_id)      { '12313131' }
  let(:api_token)       { '_token_' }
  let(:subject)         { PivotalTracker.new(config) }
  let(:config)          { {project_id: project_id,
                           api_token: api_token,
                           format: format} }

  let(:formatter)       { double 'StoryFormatter' }
  let(:blanket)         { double 'Blanket' }
  let(:projects)        { double 'Projects' }
  let(:stories)         { double 'Stories' }
  let(:get)             { double 'Get' }

  let(:options)         { { with_state: 'delivered' } }

  before do
    # Mock Story Formatter
    allow(formatter).to receive(:wrap)

    expect(StoryFormatter)
      .to receive(:new)
            .with(format, story_url)
            .and_return(formatter)

    # Mock Blanket API Wrapper
    allow(get)
      .to receive(:payload).and_return([])

    allow(stories)
      .to receive(:get)
            .with({ params: options })
            .and_return(get)

    allow(projects)
      .to receive(:stories)
            .and_return(stories)

    allow(blanket)
      .to receive(:projects)
            .with(project_id)
            .and_return(projects)

    subject.api = blanket
  end

  context "plaintext output" do
    let(:format) { "plaintext" }

    it 'request output in plaintext format' do
      subject.delivered_stories
    end
  end

  context "markdown output" do
    let(:format) { "markdown" }

    it 'request output in markdown format' do
      subject.delivered_stories
    end
  end

  context "HTML output" do
    let(:format) { "html" }

    it 'request output in html format' do
      subject.delivered_stories
    end
  end
end
