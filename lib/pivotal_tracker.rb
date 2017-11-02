require 'blanket'

module TrackerDeliveries
  class PivotalTracker
    PIVOTAL_API_URL = 'https://www.pivotaltracker.com/services/v5/'

    attr_accessor :api

    def initialize project_id, api_key, options = {}
      @api_key = api_key
      @project_id = project_id
      @format_tools = TrackerDeliveries::FormatTools.new options[:format] || :plaintext
      @api = Blanket.wrap PIVOTAL_API_URL,
                          headers: { 'X-TrackerToken' => @api_key }
    end

    def delivered_stories
      options = {with_state: "delivered"}
      wrap_output(api
                    .projects(@project_id)
                    .stories
                    .get(params: options)
                    .payload
                    .map{|s| story_formatter s }
                    .join("\n"))
    end

    def wrap_output output
      @format_tools.wrap_output output
    end

    def story_formatter story
      @format_tools.story_formatter story
    end
  end
end
