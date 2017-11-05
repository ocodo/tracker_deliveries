class TrackerDeliveries::Formatters::Plaintext < TrackerDeliveries::Formatters::StoryFormat
  def format story
    %Q{#{story.id} - #{story.name}}
  end
end
