<img src="app/assets/images/logo.png" width="400"><br>

![rails-badge](https://img.shields.io/badge/Rails-6.1.0-informational?style=flat-square) ![ruby-badge](https://img.shields.io/badge/Ruby-2.5.3-informational?style=flat-square) ![build-badge](https://img.shields.io/travis/leahriffell/photo_repo_api/main?style=flat-square) ![closed-pr-badge](https://img.shields.io/github/issues-pr-closed-raw/leahriffell/photo_repo_api?style=flat-square)

This [GraphQL on Rails API](https://photo-repo-api.herokuapp.com/graphql) serves queries and mutations for Virtual Escape, an application that allows you to travel in covid-safe style from your couch (or, let's be real, bed). There's a whole world out there so put on your best sweats amd come TFH (travel from home)!

What can I do on Virtual Escape?
  - Search for a destination and see matching photos
  - Create trips (these could be places that you've been to or have yet to visit)
  - Add photos to your trip
    - upload a file
    - or save from your search results

## Readme Content
- [Approaching the Challenge](#approaching-the-challenge)
- [User Interface](#user-interface)
- [Local Setup](#local-setup)
- [External APIs](#external-apis)
- [Test Suite](#test-suite)
- [GraphQL Schema](#graphql-schema)
- [Database Schema](#database-schema)
- [Project Tracking](#project-tracking)
- [Contributor](#contributor)

## Approaching the Challenge

## User Interface
I created this API for my application to Shopify's Backend Engineering Internship program.  This is an API only (no user interface) but I plan to build out a React frontend for Virtual Escape.

## Local Setup
- Versions
  - Rails 6.1.0
  - Ruby 2.5.3
- Fork and clone the repository
- `cd` in your local repo version and run the following commands
  - To install gems:
    -  `bundle` (if this fails, try to `bundle update` and then retry)
  - This API uses a few [external APIs](#external-apis)
    - Add a local application.yml file at the root (this will be ignored in gitcoverage)
    - Get API keys for the [Unsplash](https://unsplash.com/join) and [Mapquest](https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register) API and add to your application.yml config: 
    ```
    PHOTOS_API_KEY: your_key_here
    GEOLOCATION_API_KEY: your_key_here
    ```
  - To setup database:
    - `rails db:create`
    - `rails db:migrate`
    - `rails db:seed`
- Run your own development server:
  - `rails s`
  - You should be able to access the GraphQL interface and see available queries and mutations via the docs on [http://localhost:3000/graphiql](http://localhost:3000/graphiql)

## External APIs
This API consumes the following APIs:
- [Unsplash Search Photos API](https://unsplash.com/documentation#search-photos) to search for images at a destination
  - Requirements for use: [properly provide attribution for the photographer and Unsplash](https://help.unsplash.com/en/articles/2511315-guideline-attribution)
- [MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/) to assign latitude and longitude to a trip's location

## Test Suite
- Run with `bundle exec rspec`
- All tests should be passing
- [num] test coverage

## GraphQL Schema
#### Resource Queries

#### Analytics Queries
  - **Top Destinations**: returns the top trip destinations, ranked highest to lowest
    - insert arg it accepts
    - return type: destination

#### Mutations

#### Types
  - Destination
    ```
      field :destination, String, null: false
      field :num_saved_trips, Integer, null: false
    ```

## Database Schema
[ insert image of schema here]

## Project Tracking
[GitHub project](https://github.com/leahriffell/photo_repo_api/projects/1)

Next priorities:
  - user authentication with Firebase or Auth0


## Contributor
- Leah Riffell |  [Github](https://github.com/leahriffell)  |  [LinkedIn](https://www.linkedin.com/in/leah-riffell/)

