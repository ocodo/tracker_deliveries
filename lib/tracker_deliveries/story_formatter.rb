module TrackerDeliveries
  class StoryFormatter
    def initialize format, link
      @link = link
      @format = format
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
      link = %Q{[#{s.id}](#{@link + s.id})}
      %Q{- #{link} - #{s.name}}
    end

    def html s
      link = %Q{<a href="#{@link + s.id}">#{s.id}</a>}
      %Q{<li>#{link} - #{s.name}</li>}
    end
  end
end
