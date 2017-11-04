require 'tracker_deliveries/version'
require 'tracker_deliveries/pivotal_tracker'
require 'tracker_deliveries/story_formatter'

module TrackerDeliveries
  class Main
    PROJECT_ID_ENV = 'TRACKER_DELIVERIES_PROJECT_ID'
    API_TOKEN_ENV = 'TRACKER_DELIVERIES_API_TOKEN'

    attr_accessor :project_id,
                  :api_token,
                  :pivotal_tracker

    def initialize(options = {})
      @project_id = ENV[PROJECT_ID_ENV]
      @api_token = ENV[API_TOKEN_ENV]

      abort "Fatal: Project ID environment variable not set (#{PROJECT_ID_ENV})" unless @project_id
      abort "Fatal: PivotalTracker API Token environment variable not set (#{API_TOKEN_ENV})" unless @api_token

      @pivotal_tracker = TrackerDeliveries::PivotalTracker.new(@project_id, @api_token, options)
    end

    def delivered_stories
      @pivotal_tracker.delivered_stories
    end
  end
end
