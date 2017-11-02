require 'blanket'
require 'tracker_deliveries/version'

module TrackerDeliveries
  class Main
    attr_accessor :project_id,
                  :api_token,
                  :pivotal_tracker

    def initialize
      @project_id = ENV['TRACKER_DELIVERIES_PROJECT_ID']
      @api_token = ENV['TRACKER_DELIVERIES_API_TOKEN']
      @pivotal_tracker = PivotalTracker.new(@project_id, @api_token)
    end

    def delivered_stories
      @pivotal_tracker.delivered_stories
    end
  end

  class PivotalTracker
    PIVOTAL_API_URL = 'https://www.pivotaltracker.com/services/v5/'
    attr_accessor :api

    def initialize project_id, api_key
      @api_key = api_key
      @project_id = project_id
      @api = Blanket.wrap PIVOTAL_API_URL,
                          headers: { 'X-TrackerToken' => @api_key }
    end

    def delivered_stories
      options = {with_state: "delivered"}
      api
        .projects(@project_id)
        .stories
        .get(params: options)
        .payload
        .map{|s| "#{s.id} - #{s.name}" }
    end
  end
end
