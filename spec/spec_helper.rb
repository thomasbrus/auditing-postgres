require 'rspec'
require 'active_record'
require 'auditing/postgres'

ActiveRecord::Base.establish_connection("postgres://postgres@localhost/auditing")

# TODO: Move to rake task
ActiveRecord::Base.connection.execute("
  CREATE EXTENSION IF NOT EXISTS hstore;

  CREATE TABLE IF NOT EXISTS modifications (
    id              SERIAL,
    request_id      INTEGER,
    object_type     VARCHAR(255) NOT NULL,
    object_id       INTEGER NOT NULL,
    object_changes  HSTORE,
    action          VARCHAR(255) NOT NULL,
    at              TIMESTAMP WITH TIME ZONE,
    timestamp       TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY (id)
  );

  CREATE INDEX ON modifications (request_id);
  CREATE INDEX ON modifications (object_type);
  CREATE INDEX ON modifications (object_id);
  CREATE INDEX ON modifications (at);
  CREATE INDEX ON modifications (timestamp);
")

# TODO: Index toevoegen voor 'changes'

def clean_sheet
  Auditing::Postgres::Modification.destroy_all
end
