require 'active_record'

namespace :db do
  task :setup do
    ActiveRecord::Base.establish_connection("postgres://postgres@localhost/auditing")

    puts "Setting up database tables ...."

    ActiveRecord::Base.connection.execute("
      CREATE EXTENSION IF NOT EXISTS hstore;

      CREATE TABLE IF NOT EXISTS modifications (
        id              SERIAL,
        request_id      INTEGER,
        object_type     VARCHAR(255) NOT NULL,
        object_id       INTEGER NOT NULL,
        object_changes  HSTORE,
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
        params          HSTORE,
        user_id         INTEGER,
        real_user_id    INTEGER,
        performed_at    TIMESTAMP WITH TIME ZONE,

        PRIMARY KEY (id)
      );

      CREATE INDEX ON requests (user_id);
      CREATE INDEX ON requests (real_user_id);
      CREATE INDEX ON requests (performed_at);
    ")

    puts "Done."
  end
end
