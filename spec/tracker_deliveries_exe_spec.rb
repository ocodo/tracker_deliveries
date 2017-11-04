require 'spec_helper'
require 'tracker_deliveries_command'

describe 'Tracker deliveries executable' do
  describe 'parsing options' do
    let(:tracker_deliveries_main) { double('TrackerDeliveries::Main') }

    before do
      allow(tracker_deliveries_main).to receive(:new).and_return(tracker_deliveries_main)
      allow(tracker_deliveries_main).to receive(:delivered_stories)
    end

    it 'recognises markdown option and forwards it' do
      expect(tracker_deliveries_main).to receive(:new).with({ format: "markdown" })
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--markdown"
    end

    it 'recognises HTML option and forwards it' do
      expect(tracker_deliveries_main).to receive(:new).with({ format: "html" })
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--html"
    end
  end
end
