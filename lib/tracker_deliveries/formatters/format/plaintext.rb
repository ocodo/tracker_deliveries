class TrackerDeliveries::Formatters::Plaintext < TrackerDeliveries::Formatters::StoryFormat
  def format_story s
    %Q{#{s.id} - #{s.name}}
  end
end
