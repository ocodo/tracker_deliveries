module TrackerDeliveries
  class FormatTools
    PIVOTAL_TRACKER_STORY_URL = 'https://pivotaltracker.com/story/show/'

    def initialize format
      @format = format
    end

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
