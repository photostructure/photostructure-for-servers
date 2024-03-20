DROP TABLE IF EXISTS AdvisoryLock;

DROP INDEX IF EXISTS lock_name_lockId_udx;

DROP INDEX IF EXISTS lock_acquired_udx;

CREATE TABLE AdvisoryLock (
  id INTEGER NOT NULL PRIMARY KEY,
  -- name of the advisory lock being requested:
  name VARCHAR(255) NOT NULL,
  -- who is requesting the advisory lock:
  lockId VARCHAR(255) NOT NULL,
  acquired INTEGER NOT NULL DEFAULT 0,
  createdAt BIGINT NOT NULL
);

CREATE UNIQUE INDEX lock_name_lockId_udx ON AdvisoryLock (name, lockId);

CREATE UNIQUE INDEX lock_acquired_udx ON AdvisoryLock (name, acquired)
WHERE
  acquired = 1;
