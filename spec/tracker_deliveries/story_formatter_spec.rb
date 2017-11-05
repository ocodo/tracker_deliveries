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

  describe 'use formatter' do
    context 'format:plaintext' do
      let(:format) { 'plaintext' }

      it 'selects Formatters::Plaintext' do
        expect(formatter).to be_instance_of Formatters::Plaintext
      end

      it 'calls #wrapper on the formatter' do
        expect_any_instance_of(Formatters::Plaintext).to receive(:wrapper)
        story_formatter.format stories
      end
    end

    context 'format:markdown' do
      let(:format) { 'markdown' }

      it 'selects Formatters::Markdown' do
        expect(formatter).to be_instance_of Formatters::Markdown
      end

      it 'calls #wrapper on the formatter' do
        expect_any_instance_of(Formatters::Markdown).to receive(:wrapper)
        story_formatter.format stories
      end
    end

    context 'format:html' do
      let(:format) { 'html' }

      it 'selects Formatters::Html' do
        expect(formatter).to be_instance_of Formatters::Html
      end

      it 'calls #wrapper on the formatter' do
        expect_any_instance_of(Formatters::Html).to receive(:wrapper)
        story_formatter.format stories
      end
    end
  end
end
