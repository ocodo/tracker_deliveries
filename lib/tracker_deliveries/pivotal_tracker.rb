require 'blanket'

module TrackerDeliveries
  class PivotalTracker
    STORY_URL = 'https://pivotaltracker.com/story/show/'
    API_URL='https://www.pivotaltracker.com/services/v5/'

    attr_accessor :api

    def initialize options = {}
      @api_token = options[:api_token]
      @project_id = options[:project_id]
      @api_url = options[:api] || API_URL

      @formatter = StoryFormatter.new(
        options[:format] || :plaintext,
        STORY_URL
      )

      @api = Blanket.wrap(
        @api_url,
        headers: {
          'X-TrackerToken' => @api_token
        }
      )
    end

    def delivered_stories
      params = {
        params:
          {
            with_state: "delivered"
          }
      }

      begin
        @formatter.format(
          api
            .projects(@project_id)
            .stories.get(params).payload
        )
      rescue Blanket::Forbidden
        STDERR.puts "PivotalTracker responded with: 403 (Forbidden) project: #{@project_id}, api_token: #{@api_token}"
      rescue Blanket::ResourceNotFound
        STDERR.puts "PivotalTracker responded with: 404 (Not Found) project: #{@project_id}, api_token: #{@api_token}"
      end
    end
  end
end
