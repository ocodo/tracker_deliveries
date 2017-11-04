require 'blanket'

module TrackerDeliveries
  class PivotalTracker
    API_URL = 'https://www.pivotaltracker.com/services/v5/'
    STORY_URL = 'https://pivotaltracker.com/story/show/'

    attr_accessor :api

    def initialize project_id, api_key, options = {}
      @api_key = api_key
      @project_id = project_id

      @formatter = StoryFormatter.new(
        options[:format] || :plaintext,
        STORY_URL
      )

      @api = Blanket.wrap(
        API_URL,
        headers: {
          'X-TrackerToken' => @api_key
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

      @formatter.wrap(
        api
          .projects(@project_id)
          .stories.get(params).payload
      )
    end
  end
end
