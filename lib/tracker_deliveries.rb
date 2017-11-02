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
    PIVOTAL_TRACKER_STORY_URL = 'https://pivotaltracker.com/story/show/'
    attr_accessor :api

    def initialize project_id, api_key, options = {}
      @api_key = api_key
      @project_id = project_id
      @format = options[:format] || :plaintext
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

    private

    def pivotal_tracker_link s
      %Q{#{PIVOTAL_TRACKER_STORY_URL}#{s.id}}
    end

    def story_formatter s
      return send(@format, s)
    end

    def wrap_output output
      return %Q{<ul>\n#{output}\n</ul>} if @format == :html
      output
    end

    def plaintext s
      %Q{#{s.id} - #{s.name}}
    end

    def markdown s
      link = %Q{[#{s.id}](#{pivotal_tracker_link s})}
      %Q{- #{link} - #{s.name}}
    end

    def html s
      link = %Q{<a href="#{pivotal_tracker_link s}">#{s.id}</a>}
      %Q{<li>#{link} - #{s.name}</li>}
    end
  end
end
