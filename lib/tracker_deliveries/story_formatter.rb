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

    def wrap stories
      wrapper stories
                .map{ |s| @formatter.format_story s }
                .join "\n"
    end

    def wrapper output
      return %Q{<ul>\n#{output}\n</ul>} if @format == :html
      output
    end
  end
end
