class TrackerDeliveries::Formatters::Markdown < TrackerDeliveries::Formatters::StoryFormat
  def format_story s
    link = %Q{[#{s.id}](#{story_url s})}
    %Q{- #{link} - #{s.name}}
  end
end
