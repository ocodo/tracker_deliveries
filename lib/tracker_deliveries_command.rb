require 'tracker_deliveries'

class TrackerDeliveriesCommand
  def initialize(tracker_deliveries = TrackerDeliveries::Main)
    @tracker_deliveries = tracker_deliveries
  end

  def path_to_resources
    File.join(File.dirname(File.expand_path(__FILE__)), '../')
  end

  def main args = nil
    project_id = args.match(
      /--tracker:project[= ] ?([0-9]*)/
    )[1] rescue nil

    api_token = args.match(
      /--tracker:token[= ]?([^ ]*)/
    )[1] rescue nil

    format = args.match(
      /--(format: *)?(markdown|html)/
    )[2] rescue "plaintext" # default

    begin
      STDOUT.puts @tracker_deliveries
        .new({format: format, project_id: project_id, api_token: api_token})
        .delivered_stories
    rescue SystemExit
      readme = File.read File.join(path_to_resources, "README.md")

      STDERR.puts "\nTracker Deliveries\n------------------\n\n",
                  readme
                    .match(/(Usage:\n.*?\n)\* \* \*/m)[1]
                    .delete('`')
                    .gsub(/\n{3,}/,"\n\n")
    end
  end
end
