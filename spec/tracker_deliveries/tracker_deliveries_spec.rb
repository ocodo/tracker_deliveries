require 'spec_helper'

include TrackerDeliveries

describe TrackerDeliveries do

  it 'has a version number' do
    expect(TrackerDeliveries::VERSION).not_to be nil
  end

  describe Main do
    let(:project_id) { 'PROJECT ID' }
    let(:api_token)  { 'API TOKEN' }

    before do
      ENV['TRACKER_DELIVERIES_PROJECT_ID'] = project_id
      ENV['TRACKER_DELIVERIES_API_TOKEN'] = api_token
    end

    context 'environment not correctly set up' do
      it 'raises an error when the project id environment variable TRACKER_DELIVERIES_PROJECT_ID is not set' do
        ENV['TRACKER_DELIVERIES_PROJECT_ID'] = nil
        ENV['TRACKER_DELIVERIES_API_TOKEN'] = api_token
        expect{ TrackerDeliveries::Main.new }.to raise_error SystemExit
      end

      it 'raises an error when the project id environment variable TRACKER_DELIVERIES_API_TOKEN is not set' do
        ENV['TRACKER_DELIVERIES_PROJECT_ID'] = project_id
        ENV['TRACKER_DELIVERIES_API_TOKEN'] = nil
        expect{ TrackerDeliveries::Main.new }.to raise_error SystemExit
      end
    end

    it 'is an instance of TrackerDeliveries::Main' do
      expect(subject).to be_instance_of TrackerDeliveries::Main
    end

    context "pivotal tracker api wrapper" do
      let(:config) { {project_id: project_id,
                      api_token: api_token,
                      format: "plaintext"} }
      let(:tracker_deliveries) { TrackerDeliveries::Main.new(config) }

      it 'is configured with options' do
        pivotal_tracker = double('pivotal_tracker')
        allow(pivotal_tracker).to receive(:delivered_stories)
        expect(PivotalTracker).to receive(:new).with(config).and_return(pivotal_tracker)
        tracker_deliveries.delivered_stories
      end

      it 'request list of delivered stories' do
        expect_any_instance_of(PivotalTracker).to receive(:delivered_stories).and_return("foo")
        expect(tracker_deliveries.delivered_stories).to eq "foo"
      end
    end
  end
end