require 'spec_helper'
require 'tracker_deliveries_command'

describe 'TrackerDeliveriesCommand' do

  describe 'exe wrapper' do
    it 'calls the command' do
      expect(
        `ruby -Ilib exe/tracker_deliveries 2>&1`.strip
      ).to eq "Fatal: Project ID environment variable not set (TRACKER_DELIVERIES_PROJECT_ID)"
    end
  end

  describe 'parsing commandline options' do
    let(:tracker_deliveries_main) { double('TrackerDeliveries::Main') }

    before do
      allow(tracker_deliveries_main).to receive(:new).and_return(tracker_deliveries_main)
      allow(tracker_deliveries_main).to receive(:delivered_stories)
    end

    it 'parses markdown option and forward it' do
      expect(tracker_deliveries_main).to receive(:new).with({ format: "markdown" })
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--markdown"
    end

    it 'parses format markdown option and forward it' do
      expect(tracker_deliveries_main).to receive(:new).with({ format: "markdown" })
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--format:markdown"
    end

    it 'parses HTML option and forward it' do
      expect(tracker_deliveries_main).to receive(:new).with({ format: "html" })
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--html"
    end

    it 'parses format HTML option and forward it' do
      expect(tracker_deliveries_main).to receive(:new).with({ format: "html" })
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--format:html"
    end
  end
end
