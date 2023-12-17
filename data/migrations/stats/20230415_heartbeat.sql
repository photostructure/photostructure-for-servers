CREATE TABLE
  IF NOT EXISTS Heartbeat (
    -- used for db health checks
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL
  ) STRICT;

CREATE UNIQUE INDEX IF NOT EXISTS heartbeat_name_udx ON Heartbeat (name);
