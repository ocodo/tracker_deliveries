module TrackerDeliveries
  class StoryFormatter
    def initialize format, base_url
      @formatter = get_formatter(format, base_url)
      @format = format
    end

    def get_formatter(format, base_url)
      TrackerDeliveries::Formatters
        .const_get(format.capitalize)
        .new(base_url)
    end

    def format stories
      @formatter.wrapper(stories)
    end
  end
end
