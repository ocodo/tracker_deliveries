# TrackerDeliveries

Generates a list of currently delivered tracker stories.

This was made to assist in automatically generating UAT release notes
for continuous delivery.

## Installation

```
gem install tracker_deliveries
```

## Usage

Define these environment variables

`TRACKER_DELIVERIES_API_TOKEN` - tracker API token.

`TRACKER_DELIVERIES_PROJECT_ID` - tracker project ID

Then run the command:

```
tracker_deliveries
```

This fetches the currently delivered tracker stories from your project
and display the id and story title.

e.g.

```
#342351 - Add widget service request to order form
#213144 - Display widget detail view UI
#341414 - Update widget quantity in shopping cart
#342155 - Localize cart in Pirate speak, arr.
```

## Pivotal Tracker API Token and Project ID

On https://www.pivotaltracker.com/profile (while logged in) the API
token is at the bottom of the page.

Visit your PivotalTracker project the `project_id` last part of
the URL, e.g. `https://www.pivotaltracker.com/n/projects/1234567` the
`project_id` is `1234567`
