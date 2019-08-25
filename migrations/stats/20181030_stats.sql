CREATE TABLE IF NOT EXISTS DirStat 
-- Used for sync service bookkeeping
(
  id integer NOT NULL PRIMARY KEY,
  uri TEXT NOT NULL,
  mtime bigint NOT NULL,
  bytes bigint NOT NULL,
  assetCount integer NOT NULL,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL,
  completedAt bigint
);

CREATE UNIQUE INDEX IF NOT EXISTS dirstat_uri_udx ON DirStat (
  uri
);
