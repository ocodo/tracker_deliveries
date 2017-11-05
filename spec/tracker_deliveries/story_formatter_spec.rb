require 'spec_helper'

include TrackerDeliveries

context 'spies' do
  let(:format) { 'plaintext' }
  let(:url) { 'base_story_url' }
  let(:formatter) {StoryFormatter
                     .new(format, url)
                     .get_formatter(format, url)}

  describe 'StoryFormatter' do

    context 'wrap' do

    end

    context 'plaintext' do
      let(:format) { 'plaintext' }

      it 'selects the required formatter' do
        expect(formatter).to be_instance_of TrackerDeliveries::Formatters::Plaintext
      end
    end

    context 'markdown' do
      let(:format) { 'markdown' }

      it 'selects the required formatter' do
        expect(formatter).to be_instance_of TrackerDeliveries::Formatters::Markdown
      end
    end

    context 'html' do
      let(:format) { 'html' }

      it 'selects the required formatter' do
        expect(formatter).to be_instance_of TrackerDeliveries::Formatters::Html
      end
    end
  end
end
