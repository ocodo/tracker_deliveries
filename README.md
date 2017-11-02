![](https://img.shields.io/github/issues/badges/ocodo/tracker_deliveries.svg)
![](https://img.shields.io/github/issues-pr/ocodo/tracker_deliveries.svg)
![](https://img.shields.io/github/license/ocodo/tracker_deliveries.svg)
![](https://img.shields.io/gem/v/tracker_deliveries.svg)
![](https://img.shields.io/circleci/project/github/ocodo/tracker_deliveries/master.svg)

# TrackerDeliveries

Generates a list of currently delivered tracker stories.

Made to assist automatically generating release notes
for continuous delivery.

## Installation

```
gem install tracker_deliveries
```

## Usage

Define these environment variables:

- `TRACKER_DELIVERIES_API_TOKEN` - tracker API token
- `TRACKER_DELIVERIES_PROJECT_ID` - tracker project ID

Run:

```
tracker_deliveries
```

Output current delivered stories ids & story titles as plaintext e.g.:

```
132412351 - Add widget service request to order form
123412144 - Display widget detail view UI
131412414 - Update widget quantity in shopping cart
132412155 - Localize cart in Pirate speak, arr.
```

### Formatting output

Generate the list with alternative formatting as Markdown or HTML (with built in links to the tracker stories):

```
tracker_deliveries --markdown
```

```
- [132412351](https://pivotaltracker.com/story/show/132412351) - Add widget service request to order form
- [123412144](https://pivotaltracker.com/story/show/123412144) - Display widget detail view UI
- [131412414](https://pivotaltracker.com/story/show/131412414) - Update widget quantity in shopping cart
- [132412155](https://pivotaltracker.com/story/show/132412155) - Localize cart in Pirate speak, arr.
```

or

```
tracker_deliveries --html
```

```
<ul>
<li><a href="https://pivotaltracker.com/story/show/132412351">132412351</a> - Add widget service request to order form</li>
<li><a href="https://pivotaltracker.com/story/show/123412144">123412144</a> - Display widget detail view UI</li>
<li><a href="https://pivotaltracker.com/story/show/131412414">131412414</a> - Update widget quantity in shopping cart</li>
<li><a href="https://pivotaltracker.com/story/show/132412155">132412155</a> - Localize cart in Pirate speak, arr.</li>
</ul>
```

Rendering as:

- [132412351](https://pivotaltracker.com/story/show/132412351) - Add widget service request to order form
- [123412144](https://pivotaltracker.com/story/show/123412144) - Display widget detail view UI
- [131412414](https://pivotaltracker.com/story/show/131412414) - Update widget quantity in shopping cart
- [132412155](https://pivotaltracker.com/story/show/132412155) - Localize cart in Pirate speak, arr.

## Get hold of the Pivotal Tracker API Token / Project ID

On https://www.pivotaltracker.com/profile (while logged in) the API
token is at the bottom of the page.

Visit your PivotalTracker project the `project_id` last part of
the URL, e.g. `https://www.pivotaltracker.com/n/projects/1234567` the
`project_id` is `1234567`

## Acknowledgements

This was built using Ruby, Rspec/TDD with Blanket Wrapper provides the
basis of the REST service client.
