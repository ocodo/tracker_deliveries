require 'tracker_deliveries/version'
require 'tracker_deliveries/pivotal_tracker'
require 'tracker_deliveries/story_formatter'
require 'tracker_deliveries/formatters/formatters'
require 'tracker_deliveries/formatters/story_format'
require 'tracker_deliveries/formatters/format/html'
require 'tracker_deliveries/formatters/format/markdown'
require 'tracker_deliveries/formatters/format/plaintext'

module TrackerDeliveries
  class Main
    API_TOKEN_ENV = 'TRACKER_DELIVERIES_API_TOKEN'
    PROJECT_ID_ENV = 'TRACKER_DELIVERIES_PROJECT_ID'
    DEBUG_URL = 'TRACKER_DELIVERIES_DEBUG_API_URL'

    FATAL_MESSAGE_API_TOKEN = "Fatal: PivotalTracker API Token environment variable not set (#{API_TOKEN_ENV})"
    FATAL_MESSAGE_PROJECT_ID = "Fatal: Project ID environment variable not set (#{PROJECT_ID_ENV})"

    def initialize(options = {})
      options.merge!({
                       api_token: ENV[API_TOKEN_ENV],
                       project_id: ENV[PROJECT_ID_ENV],
                       api: ENV[DEBUG_URL]
                     }) do |_, default, option|
        default || option
      end

      abort(FATAL_MESSAGE_API_TOKEN) unless options[:api_token]
      abort(FATAL_MESSAGE_PROJECT_ID) unless options[:project_id]

      @pivotal_tracker = TrackerDeliveries::PivotalTracker.new(options)
    end

    def delivered_stories
      @pivotal_tracker.delivered_stories
    end
  end
end
