require 'tracker_deliveries/version'
require 'tracker_deliveries/pivotal_tracker'
require 'tracker_deliveries/format_tools'

module TrackerDeliveries
  class Main
    attr_accessor :project_id,
                  :api_token,
                  :pivotal_tracker

    def initialize(options = {})
      @project_id = ENV['TRACKER_DELIVERIES_PROJECT_ID']
      @api_token = ENV['TRACKER_DELIVERIES_API_TOKEN']

      @pivotal_tracker = TrackerDeliveries::PivotalTracker.new(@project_id, @api_token, options)
    end

    def delivered_stories
      @pivotal_tracker.delivered_stories
    end
  end
end
