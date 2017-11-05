require 'spec_helper'

include TrackerDeliveries

describe StoryFormatter do
  let(:format) { 'plaintext' }
  let(:url) { 'base_story_url' }
  let(:formatter) {StoryFormatter
                     .new(format, url)
                     .get_formatter(format, url)}

  context 'plaintext' do
    let(:format) { 'plaintext' }

    it 'selects the required formatter' do
      expect(formatter).to be_instance_of Formatters::Plaintext
    end
  end

  context 'markdown' do
    let(:format) { 'markdown' }

    it 'selects the required formatter' do
      expect(formatter).to be_instance_of Formatters::Markdown
    end
  end

  context 'html' do
    let(:format) { 'html' }

    it 'selects the required formatter' do
      expect(formatter).to be_instance_of Formatters::Html
    end
  end
end
