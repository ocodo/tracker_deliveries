class TrackerDeliveries::Formatters::StoryFormat
  def initialize base_url
    @base_url = base_url
  end

  def story_url story
    @base_url + story.id
  end

  def format story
    raise Error 'Abstract method: not implemented'
  end

  def wrapper stories
    stories
      .map{|s| self.format s }
      .join("\n")
  end
end
