require 'spec_helper'

include TrackerDeliveries

describe StoryFormatter do
  let(:format) { 'plaintext' }
  let(:url) { 'base_story_url' }
  let(:story_formatter) { StoryFormatter.new(format, url) }
  let(:formatter) { story_formatter.get_formatter(format, url) }
  let(:story_one) { OpenStruct.new({id: '123456', name: 'Story one'}) }
  let(:story_two) { OpenStruct.new({id: '654321', name: 'Story two'}) }
  let(:stories) { [story_one, story_two] }

  context 'Formatters::Plaintext' do
    let(:format) { 'plaintext' }

    it 'selects the required formatter' do
      expect(formatter).to be_instance_of Formatters::Plaintext
    end

    it 'formats stories' do
      expect(story_formatter.wrap(stories))
        .to eq "123456 - Story one\n" +
               "654321 - Story two"
    end
  end

  context 'Formatters::Markdown' do
    let(:format) { 'markdown' }

    it 'selects the required formatter' do
      expect(formatter).to be_instance_of Formatters::Markdown
    end

    it 'formats stories' do
      expect(story_formatter.wrap(stories))
        .to eq "- [123456](base_story_url123456) - Story one\n" +
               "- [654321](base_story_url654321) - Story two"
    end
  end

  context 'Formatters::Html' do
    let(:format) { 'html' }

    it 'selects the required formatter' do
      expect(formatter).to be_instance_of Formatters::Html
    end

    it 'formats stories' do
      expect(story_formatter.wrap(stories))
        .to eq "<ul>\n" +
               "<li><a href=\"base_story_url123456\">123456</a> - Story one</li>\n" +
               "<li><a href=\"base_story_url654321\">654321</a> - Story two</li>\n" +
               "</ul>"
    end
  end
end
