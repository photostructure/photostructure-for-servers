-- What we should be able to do:
-- ALTER TABLE DirStat DROP COLUMN bytes;
-- But because it's OK to just nuke DirStat, let's do that.
DROP TABLE IF EXISTS DirStat;

CREATE TABLE
  DirStat (
    -- Used for sync service bookkeeping
    id INTEGER NOT NULL PRIMARY KEY,
    uri TEXT NOT NULL,
    mtime INTEGER NOT NULL,
    assetCount INTEGER NOT NULL,
    fileCount INTEGER NOT NULL,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL,
    completedAt INTEGER
  ) STRICT;

CREATE UNIQUE INDEX IF NOT EXISTS dirstat_uri_udx ON DirStat (uri);
