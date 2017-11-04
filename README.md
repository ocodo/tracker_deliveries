![](https://img.shields.io/github/issues/badges/ocodo/tracker_deliveries.svg)
![](https://img.shields.io/github/issues-pr/ocodo/tracker_deliveries.svg)
![](https://img.shields.io/github/license/ocodo/tracker_deliveries.svg)
![](https://img.shields.io/gem/v/tracker_deliveries.svg)
![](https://img.shields.io/circleci/project/github/ocodo/tracker_deliveries/master.svg)

# TrackerDeliveries

A command-line tool (and ruby gem) to generate a list of Pivotal Tracker
stories that are delivered for a project.

It was made to assist automatically generating release notes
for continuous delivery.

## Installation

```
gem install tracker_deliveries
```

## Usage:

```
tracker_deliveries [options]
```

options:

```
    --tracker:token=TOKEN        PivotalTracker API Token
    --tracker:project=PROJECT_ID PivotalTracker project id
    --format:FORMAT              plaintext|html|markdown (default: plaintext)
```

Environment variables can be used for `TOKEN` or `PROJECT_ID`.

`TRACKER_DELIVERIES_PROJECT_ID`
`TRACKER_DELIVERIES_API_TOKEN`

Show the current delivered stories as id and title.

Story ids will link back to PivotalTracker when using
`--format:markdown` or `--format:html`

* * *

# Example output

132412351 - Add widget service request to order form
123412144 - Display widget detail view UI
131412414 - Update widget quantity in shopping cart
132412155 - Localize cart in Pirate speak, arr.

## How do I get the Pivotal Tracker API Token & Project ID?

Login to PivotalTracker and visit https://www.pivotaltracker.com/profile
The API token is at the bottom of the page.

Visit your PivotalTracker project the `project_id` last part of
the URL, e.g. `https://www.pivotaltracker.com/n/projects/1234567` the
`project_id` is `1234567`

## Acknowledgements

This was built using Ruby, Rspec/TDD with Blanket Wrapper provides the
basis of the REST service client.
