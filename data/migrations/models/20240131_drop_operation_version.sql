CREATE TABLE Operation_new (
  -- used to store operations, like "forced" syncs, and library rebuilds
  id INTEGER NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  value TEXT,
  createdAt INTEGER NOT NULL,
  updatedAt INTEGER NOT NULL,
  completedAt INTEGER
) STRICT;

INSERT INTO
  Operation_new (
    id,
    name,
    value,
    createdAt,
    updatedAt,
    completedAt
  )
SELECT
  id,
  name,
  value,
  createdAt,
  updatedAt,
  completedAt
FROM
  Operation;

DROP TABLE Operation;

ALTER TABLE Operation_new
RENAME TO Operation;
