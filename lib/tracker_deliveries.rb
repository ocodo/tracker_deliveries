require 'blanket'
require 'tracker_deliveries/version'

module TrackerDeliveries
  class Main
    attr_accessor :project_id,
                  :api_token,
                  :pivotal_tracker

    def initialize(options = {})
      @project_id = ENV['TRACKER_DELIVERIES_PROJECT_ID']
      @api_token = ENV['TRACKER_DELIVERIES_API_TOKEN']
      @pivotal_tracker = PivotalTracker.new(@project_id, @api_token, options)
    end

    def delivered_stories
      @pivotal_tracker.delivered_stories
    end
  end

  class PivotalTracker
    PIVOTAL_API_URL = 'https://www.pivotaltracker.com/services/v5/'
    attr_accessor :api

    def initialize project_id, api_key, options = {}
      @api_key = api_key
      @project_id = project_id
      @markdown = options[:format] == :markdown
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
        .map{|s| story_formatter s }
    end

    private

    def story_formatter s
      return markdown_formatter s if @markdown
      return plaintext_formatter s
    end

    def plaintext_formatter s
      "#{s.id} - #{s.name}"
    end

    def markdown_formatter s
      link = "[#{s.id}](https://pivotaltracker.com/story/show/#{s.id})"
      "#{link} - #{s.name}"
    end
  end
end
