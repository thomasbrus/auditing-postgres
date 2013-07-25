auditing-postgres
=================

Audit modifications &amp; requests using Postgres.

## Installation

Add this line to your application's Gemfile:

    gem 'auditing-postgres', git: 'git://github.com/thomasbrus/auditing-postgres.git', ref: '<ref>'

And then execute:

    $ bundle

## Setup

Run this `db/tables.sql` against your prefered database:

    psql -U postgres pep_auditing -f db/tables.sql

And then set the database connection string:

    Auditing::Postgres.configure do |config|
      config.db = 'postgres://postgres@localhost/pep_auditing'
    end

## Tests

`bundle exec rspec`
