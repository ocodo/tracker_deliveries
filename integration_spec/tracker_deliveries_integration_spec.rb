require 'spec_helper'
require 'open3'

include TrackerDeliveries

def capture_shell(command)
  stdout, stderr, status = Open3.capture3 command
  {stdout: stdout, stderr: stderr, status: status}
end

describe 'tracker_deliveries' do
  describe 'runtime errors' do
    let(:env) { '' }
    let(:options) { '' }
    let(:command) { "#{env} ruby -Ilib exe/tracker_deliveries #{options}" }

    it 'aborts with an API_TOKEN error and usage notes when no mandatory options or usable environment is provided' do
      expect(capture_shell(command)[:stdout]).to eq ''
      expect(capture_shell(command)[:stderr]).to include Main::FATAL_MESSAGE_API_TOKEN
      expect(capture_shell(command)[:stderr]).to include 'Tracker Deliveries'
      expect(capture_shell(command)[:stderr]).to include 'Usage'
      expect(capture_shell(command)[:stderr]).to include ''
    end

    context 'only api_token' do
      context 'in environment' do
        let(:env) { 'TRACKER_DELIVERIES_API_TOKEN=FAKE_TOKEN' }
        it 'aborts with a PROJECT_ID error and usage notes when no mandatory options or usable environment is provided' do
          expect(capture_shell(command)[:stdout]).to eq ''
          expect(capture_shell(command)[:stderr]).to include Main::FATAL_MESSAGE_PROJECT_ID
          expect(capture_shell(command)[:stderr]).to include 'Tracker Deliveries'
          expect(capture_shell(command)[:stderr]).to include 'Usage'
          expect(capture_shell(command)[:stderr]).to include ''
        end
      end

      context 'in option switch' do
        let(:options) { '--tracker:token=fake_token' }
        it 'aborts with a PROJECT_ID error and usage notes when no mandatory options or usable environment is provided' do
          expect(capture_shell(command)[:stdout]).to eq ''
          expect(capture_shell(command)[:stderr]).to include Main::FATAL_MESSAGE_PROJECT_ID
          expect(capture_shell(command)[:stderr]).to include 'Tracker Deliveries'
          expect(capture_shell(command)[:stderr]).to include 'Usage'
          expect(capture_shell(command)[:stderr]).to include ''
        end
      end
    end

    context 'only project_id' do
      context 'in environment' do
        let(:env) { 'TRACKER_DELIVERIES_PROJECT_ID=1234' }
        it 'aborts with a PROJECT_ID error and usage notes when no mandatory options or usable environment is provided' do
          expect(capture_shell(command)[:stdout]).to eq ''
          expect(capture_shell(command)[:stderr]).to include Main::FATAL_MESSAGE_API_TOKEN
          expect(capture_shell(command)[:stderr]).to include 'Tracker Deliveries'
          expect(capture_shell(command)[:stderr]).to include 'Usage'
          expect(capture_shell(command)[:stderr]).to include ''
        end
      end

      context 'in option switch' do
        context 'with =' do
          let(:options) { '--tracker:project=1234' }
          it 'aborts with a PROJECT_ID error and usage notes when no mandatory options or usable environment is provided' do
            expect(capture_shell(command)[:stdout]).to eq ''
            expect(capture_shell(command)[:stderr]).to include Main::FATAL_MESSAGE_API_TOKEN
            expect(capture_shell(command)[:stderr]).to include 'Tracker Deliveries'
            expect(capture_shell(command)[:stderr]).to include 'Usage'
            expect(capture_shell(command)[:stderr]).to include ''
          end
        end

        context 'with space' do
          let(:options) { '--tracker:project 1234' }
          it 'aborts with a PROJECT_ID error and usage notes when no mandatory options or usable environment is provided' do
            expect(capture_shell(command)[:stdout]).to eq ''
            expect(capture_shell(command)[:stderr]).to include Main::FATAL_MESSAGE_API_TOKEN
            expect(capture_shell(command)[:stderr]).to include 'Tracker Deliveries'
            expect(capture_shell(command)[:stderr]).to include 'Usage'
            expect(capture_shell(command)[:stderr]).to include ''
          end
        end
      end
    end

    context 'both api token and project id (testing against wiremock)' do
      before :all do
        ENV['TRACKER_DELIVERIES_DEBUG_API_URL'] = 'http://localhost:4567'
      end

      after :all do
        ENV['TRACKER_DELIVERIES_DEBUG_API_URL'] = nil
      end

      context 'env' do
        let(:env) { 'TRACKER_DELIVERIES_PROJECT_ID=1234 TRACKER_DELIVERIES_API_TOKEN=FAKE' }
        it 'Connects to Pivotal Tracker with project and api token' do
          expect((capture_shell(command)[:stderr]).chomp).to eq ''
          expect((capture_shell(command)[:stdout]).chomp).to eq "123456 - Story one\n654321 - Story two"
        end
      end

      context 'options' do
        let(:options) { '--tracker:project=1234 --tracker:token=FAKE' }
        it 'Connects to Pivotal Tracker with project and api token' do
          expect((capture_shell(command)[:stderr]).chomp).to eq ''
          expect((capture_shell(command)[:stdout]).chomp).to eq "123456 - Story one\n654321 - Story two"
        end
      end

      context 'project not found' do
        let(:options) { '--tracker:project=404 --tracker:token=FAKE' }
        it 'Connects to Pivotal Tracker and passes back a 404 error' do
          expect((capture_shell(command)[:stderr]).chomp).to eq 'PivotalTracker responded with: 404 (Not Found) project: 404, api_token: FAKE'
          expect((capture_shell(command)[:stdout]).chomp).to eq ''
        end
      end
      context 'no access to project' do
        let(:options) { '--tracker:project=403 --tracker:token=FAKE' }
        it 'Connects to Pivotal Tracker and passes back a 403 error' do
          expect((capture_shell(command)[:stderr]).chomp).to eq 'PivotalTracker responded with: 403 (Forbidden) project: 403, api_token: FAKE'
          expect((capture_shell(command)[:stdout]).chomp).to eq ''
        end
      end
    end
  end
end
