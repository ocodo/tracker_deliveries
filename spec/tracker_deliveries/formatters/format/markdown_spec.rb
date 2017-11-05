require 'spec_helper'

include TrackerDeliveries::Formatters

describe Markdown do
  let(:story_base_url) { '//base_url/'  }
  let(:subject) { Markdown.new story_base_url }
  let(:story) {OpenStruct.new({id: '123456', name: 'Story title'}) }
  let(:stories) { [story, story] }
  let(:formatted_story) { %Q{- [123456](//base_url/123456) - Story title} }
  let(:wrapped_stories) { %Q{- [123456](//base_url/123456) - Story title\n- [123456](//base_url/123456) - Story title} }

  describe '#format' do
    it 'formats story as markdown' do
      expect(subject.format(story)).to eq formatted_story
    end
  end

  describe '#wrapper' do
    it 'wraps formatted stories in an unordered markdown list' do
      expect(subject.wrapper(stories)).to eq wrapped_stories
    end
  end
end
