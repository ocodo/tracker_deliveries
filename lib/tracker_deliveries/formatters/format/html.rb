require 'pry-byebug'

class TrackerDeliveries::Formatters::Html < TrackerDeliveries::Formatters::StoryFormat
  def format s
    link = %Q{<a href="#{story_url s}">#{s.id}</a>}
    %Q{<li>#{link} - #{s.name}</li>}
  end

  def wrapper stories
    formatted = super stories
    %Q{<ul>\n#{formatted}\n</ul>}
  end
end
