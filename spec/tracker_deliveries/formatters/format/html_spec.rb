require 'spec_helper'

include TrackerDeliveries::Formatters

describe Html do
  let(:story_base_url) { '//base_url/'  }
  let(:subject) { Html.new story_base_url }
  let(:story) { OpenStruct.new({id: '123456',
                                name: 'Story title'}) }
  let(:stories) { [story, story] }
  let(:formatted_story) { %Q{<li><a href="//base_url/123456">123456</a> - Story title</li>} }
  let(:wrapped_stories) { %Q{<ul>\n<li><a href="//base_url/123456">123456</a> - Story title</li>\n<li><a href="//base_url/123456">123456</a> - Story title</li>\n</ul>} }

  describe '#format' do
    it 'formats story as HTML' do
      expect(subject.format(story)).to eq formatted_story
    end
  end

  describe '#wrapper' do
    it 'wraps formatted stories in an unordered HTML list' do
      expect(subject.wrapper(stories)).to eq wrapped_stories
    end
  end
end
