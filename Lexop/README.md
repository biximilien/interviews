# Interview

# Backend Developer Technical Assessment

Complete this mini-project within two days and submit it through a private GitHub repository. The repository should contain all project files except generated database and log files.

## Problem

Build a web application that allows users to browse news articles, filter them by category or author, like individual articles, and view a bar chart showing daily likes for each article.

## Requirements

Users must be able to:

* List all imported news articles.
* Filter articles by category.
* Filter articles by author.
* Read an individual article.
* Like an article.
* View a bar chart of likes per day for an article.

## Provided Data

The supplied archive contains:

* A `news_articles.csv` file with article metadata.
* One HTML file containing the body of each article.

The CSV contains the following columns:

```text
title, publication_date, author, category, like_counts_per_date
```

All values are double-quoted and comma-separated.

`publication_date` uses the `YYYY-MM-DD` format.

`like_counts_per_date` contains pipe-separated `date:count` pairs:

```text
2029-10-17:15|2029-10-18:20|2029-10-19:30
```

Each article title is unique.

Each HTML filename is derived from its article title by:

* Replacing spaces, dashes, and forward slashes with underscores.
* Removing periods, colons, apostrophes, and percent signs.
* Appending the `.html` extension.

For example:

```text
Montreal Hawks Minor League Baseball Team Wins Championship
```

becomes:

```text
montreal_hawks_minor_league_baseball_team_wins_championship.html
```

The archive must be manually extracted into the project’s `/data` directory before running the import task.

## Technical Specification

The backend must be implemented with Ruby on Rails.

The application must include:

* An article index page displaying:

  * Title
  * Publication date
  * Author
  * Category
  * Total number of likes
  * A body excerpt of no more than 200 characters, ending with `...`
* An article detail page displaying:

  * Title
  * Publication date
  * Author
  * Category
  * Total number of likes
  * Full HTML body
* Category and author filters.
* An action for liking an article.
* A recognizable bar chart showing likes per day.
* A Rake task named `import:news_articles`.

The import task must load:

```text
/data/news_articles.csv
```

and its corresponding HTML files into the database.

## Constraints

* Ruby 2.7 or newer.
* Rails 6.0 or newer.
* SQLite database.
* The submitted repository must not include the generated database.
* The solution must use Rails routes, controllers, ERB views, Active Record models, and migrations.
* Additional Ruby classes or modules may be used.
* Rails scaffolding is permitted.
* The article model must validate:

  * Unique title
  * Presence of title
  * Presence of body
  * Presence of author
  * Presence of publication date
  * Presence of category
* The import task must be idempotent.
* Backend code must be covered by automated tests.
* RSpec, Minitest, or another testing framework may be used.
* An entity-relationship diagram must be included.
* External libraries are optional.
* Visual design is not evaluated, except that the likes chart must be clearly recognizable as a bar chart.


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
