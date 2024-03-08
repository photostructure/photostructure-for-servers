CREATE TABLE Progress_new (
  -- records sync process state
  id INTEGER NOT NULL PRIMARY KEY,
  uri TEXT NOT NULL,
  hostname TEXT NOT NULL,
  pid INTEGER NOT NULL,
  volume TEXT NOT NULL,
  state TEXT,
  hed TEXT,
  dekJSON TEXT,
  completePct REAL,
  incompletePct REAL,
  scanningPct REAL,
  createdAt INTEGER NOT NULL,
  updatedAt INTEGER NOT NULL,
  completedAt INTEGER
) STRICT;

INSERT INTO
  Progress_new (
    id,
    uri,
    hostname,
    pid,
    volume,
    state,
    hed,
    dekJSON,
    completePct,
    incompletePct,
    scanningPct,
    createdAt,
    updatedAt,
    completedAt
  )
SELECT
  id,
  uri,
  hostname,
  pid,
  volume,
  state,
  hed,
  dekJSON,
  completePct,
  incompletePct,
  scanningPct,
  createdAt,
  updatedAt,
  completedAt
FROM
  Progress;

DROP TABLE Progress;

ALTER TABLE Progress_new
RENAME TO Progress;
