auditing-postgres
=================

Audit modifications &amp; requests using Postgres.

## Installation

Add this line to your application's Gemfile:

    gem 'auditing-postgres', git: 'git://github.com/thomasbrus/auditing-postgres.git', ref: '<ref>'

And then execute:

    $ bundle

## Setup

Run this SQL in your prefered database:

    CREATE TABLE IF NOT EXISTS modifications (
      id              SERIAL,
      request_id      INTEGER,
      object_type     VARCHAR(255) NOT NULL,
      object_id       INTEGER NOT NULL,
      object_changes  TEXT,
      action          VARCHAR(255) NOT NULL,
      performed_at    TIMESTAMP WITH TIME ZONE,

      PRIMARY KEY (id)
    );

    CREATE INDEX ON modifications (request_id);
    CREATE INDEX ON modifications (object_type);
    CREATE INDEX ON modifications (object_id);
    CREATE INDEX ON modifications (object_changes);
    CREATE INDEX ON modifications (performed_at);

    CREATE TABLE IF NOT EXISTS requests (
      id              SERIAL,
      url             VARCHAR(1024),
      method          VARCHAR(255),
      params          TEXT,
      user_id         INTEGER,
      real_user_id    INTEGER,
      performed_at    TIMESTAMP WITH TIME ZONE,

      PRIMARY KEY (id)
    );

    CREATE INDEX ON requests (user_id);
    CREATE INDEX ON requests (real_user_id);
    CREATE INDEX ON requests (performed_at);

And then set the database connection string:

    Auditing::Postgres.configure do |config|
      config.db = 'postgres://postgres@localhost/pep_auditing'
    end

## Tests

`bundle exec rspec`
