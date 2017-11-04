module TrackerDeliveries
  class StoryFormatter
    def initialize format, story_link
      @story_link = story_link
      @format = format
    end

    def wrap stories
      wrapper stories
                .map{|s| format_story s}
                .join "\n"

    end

    def wrapper output
      return %Q{<ul>\n#{output}\n</ul>} if @format == :html
      output
    end

    def story_url s
      @story_link + s.id
    end

    def format_story s
      return send(@format, s)
    end

    def plaintext s
      %Q{#{s.id} - #{s.name}}
    end

    def markdown s
      link = %Q{[#{s.id}](#{story_url s})}
      %Q{- #{link} - #{s.name}}
    end

    def html s
      link = %Q{<a href="#{story_url s}">#{s.id}</a>}
      %Q{<li>#{link} - #{s.name}</li>}
    end
  end
end
