require 'spec_helper'

include TrackerDeliveries::Formatters

describe Plaintext do
  let(:story_base_url) { '//base_url/'  }
  let(:subject) { Plaintext.new story_base_url }
  let(:story) { OpenStruct.new({id: '123456', name: 'Story title'}) }
  let(:formatted_story) { '123456 - Story title' }
  let(:wrapped_stories) { %Q{#{formatted_story}\n#{formatted_story}} }
  let(:stories) { [story, story] }

  describe '#format' do
    it 'formats story as plaintext' do
      expect(subject.format(story)).to eq formatted_story
    end
  end

  describe '#wrapper' do
    it 'wraps formatted stories in an unordered plaintext list' do
      expect(subject.wrapper(stories)).to eq wrapped_stories
    end
  end
end
