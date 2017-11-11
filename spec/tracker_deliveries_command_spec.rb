require 'spec_helper'
require 'tracker_deliveries_command'

describe 'TrackerDeliveriesCommand' do
  describe 'parsing commandline options' do
    let(:tracker_deliveries_main) { double('TrackerDeliveries::Main') }

    before do
      allow(tracker_deliveries_main).to receive(:new).and_return(tracker_deliveries_main)
      allow(tracker_deliveries_main).to receive(:delivered_stories)
    end

    example '--markdown' do
      expect(tracker_deliveries_main).to receive(:new).with(hash_including({ format: "markdown" }))
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--markdown"
    end

    example '--format:markdown' do
      expect(tracker_deliveries_main).to receive(:new).with(hash_including({ format: "markdown" }))
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--format:markdown"
    end

    example '--html' do
      expect(tracker_deliveries_main).to receive(:new).with(hash_including({ format: "html" }))
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--html"
    end

    example '--format:html' do
      expect(tracker_deliveries_main).to receive(:new).with(hash_including({ format: "html" }))
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--format:html"
    end

    example '--tracker:token TOKEN' do
      expect(tracker_deliveries_main).to receive(:new).with(hash_including({ api_token: "TOKEN" }))
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--tracker:token TOKEN"
    end

    example '--tracker:token=TOKEN' do
      expect(tracker_deliveries_main).to receive(:new).with(hash_including({ api_token: "TOKEN" }))
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--tracker:token=TOKEN"
    end

    example '--tracker:project PROJECT_ID' do
      expect(tracker_deliveries_main).to receive(:new).with(hash_including({ project_id: "12345678" }))
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--tracker:project 12345678"
    end

    example '--tracker:project=PROJECT_ID' do
      expect(tracker_deliveries_main).to receive(:new).with(hash_including({ project_id: "12345678" }))
      TrackerDeliveriesCommand.new(tracker_deliveries_main).main "--tracker:project=12345678"
    end
  end
end
