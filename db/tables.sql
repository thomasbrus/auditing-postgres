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