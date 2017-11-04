require 'tracker_deliveries'

class TrackerDeliveriesCommand
  def initialize(tracker_deliveries = TrackerDeliveries::Main)
    @tracker_deliveries = tracker_deliveries
  end

  def main args = nil
    format = case args
             when /--(format: *)?markdown/
               "markdown"
             when /--(format: *)?html/
               "html"
             when /--(format: *)?plaintext/
               "plaintext"
             else
               "plaintext"
             end

    STDOUT.puts @tracker_deliveries
      .new(format: format)
      .delivered_stories
  end
end
