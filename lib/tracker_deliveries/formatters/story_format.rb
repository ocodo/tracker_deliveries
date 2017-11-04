class TrackerDeliveries::Formatters::StoryFormat
  def initialize url
    @url = url
  end

  def story_url s
    @url + s.id
  end
end
