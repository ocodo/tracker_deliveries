class TrackerDeliveries::Formatters::Html < TrackerDeliveries::Formatters::StoryFormat
  def format_story s
    link = %Q{<a href="#{story_url s}">#{s.id}</a>}
    %Q{<li>#{link} - #{s.name}</li>}
  end
end
