CREATE TABLE IF NOT EXISTS AdvisoryLock (
  id INTEGER NOT NULL PRIMARY KEY,
  -- name of the advisory lock being requested:
  name VARCHAR(255) NOT NULL,
  -- who is requesting the advisory lock:
  lockId VARCHAR(255) NOT NULL,
  acquired INTEGER NOT NULL DEFAULT 0,
  createdAt BIGINT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS lock_name_lockId_udx ON AdvisoryLock (name, lockId);

CREATE UNIQUE INDEX IF NOT EXISTS lock_acquired_udx ON AdvisoryLock (name, acquired)
WHERE
  acquired = 1;
