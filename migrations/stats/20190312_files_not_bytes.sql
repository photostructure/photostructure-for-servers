-- What we should be able to do:
-- ALTER TABLE DirStat DROP COLUMN bytes;

-- But because it's OK to just nuke DirStat, let's do that.

DROP TABLE IF EXISTS DirStat;

CREATE TABLE IF NOT EXISTS DirStat 
-- Used for sync service bookkeeping
(
  id integer NOT NULL PRIMARY KEY,
  uri TEXT NOT NULL,
  mtime bigint NOT NULL,
  assetCount integer NOT NULL,
  fileCount integer NOT NULL,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL,
  completedAt bigint
);

CREATE UNIQUE INDEX IF NOT EXISTS dirstat_uri_udx ON DirStat (
  uri
);
