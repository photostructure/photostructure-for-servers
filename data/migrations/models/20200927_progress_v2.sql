DROP TABLE IF EXISTS Progress;

DROP INDEX IF EXISTS progress_uri_udx;

CREATE TABLE Progress (
  -- records sync process state
  id INTEGER NOT NULL PRIMARY KEY,
  uri VARCHAR(255) NOT NULL,
  hostname VARCHAR(255) NOT NULL,
  pid BIGINT NOT NULL,
  volume VARCHAR(255) NOT NULL,
  state VARCHAR(255),
  hed VARCHAR(255),
  dekJSON VARCHAR(255),
  completePct INTEGER,
  incompletePct INTEGER,
  scanningPct INTEGER,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  completedAt BIGINT
);

CREATE INDEX progress_updated_at_idx ON Progress (updatedAt);
