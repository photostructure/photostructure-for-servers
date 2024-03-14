DROP INDEX IF EXISTS progressmeta_fk_name_udx;

DROP TABLE IF EXISTS ProgressMeta;

CREATE TABLE ProgressMeta (
  -- Used to store state of a sync. Prevents future sync jobs from re-doing prior work.
  id INTEGER NOT NULL PRIMARY KEY,
  progressId INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  value VARCHAR(255) NOT NULL,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  FOREIGN KEY (progressId) REFERENCES Progress (id)
);

CREATE UNIQUE INDEX progressmeta_fk_name_udx ON ProgressMeta (progressId, name);
