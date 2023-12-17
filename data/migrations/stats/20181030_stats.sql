CREATE TABLE
  IF NOT EXISTS DirStat (
    -- Used for sync service bookkeeping
    id INTEGER NOT NULL PRIMARY KEY,
    uri TEXT NOT NULL,
    mtime INTEGER NOT NULL,
    bytes INTEGER NOT NULL,
    assetCount INTEGER NOT NULL,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL,
    completedAt INTEGER
  ) STRICT;

CREATE UNIQUE INDEX IF NOT EXISTS dirstat_uri_udx ON DirStat (uri);
