require 'tracker_deliveries'

class TrackerDeliveriesCommand
  def initialize(tracker_deliveries = TrackerDeliveries::Main)
    @tracker_deliveries = tracker_deliveries
  end

  def main format
    if format == '--markdown'
      puts @tracker_deliveries
        .new(format: "markdown").delivered_stories
    elsif format == '--html'
      puts @tracker_deliveries
        .new(format: "html").delivered_stories
    else
      puts @tracker_deliveries
        .new().delivered_stories
    end
  end
end
