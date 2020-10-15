CREATE TABLE ProgressMeta (
  -- Used to store state of a sync. Prevents future sync jobs from re-doing prior work.
  id integer NOT NULL PRIMARY KEY,
  progressId integer NOT NULL,
  name varchar(255) NOT NULL,
  value varchar(255) NOT NULL,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL,
  FOREIGN KEY(progressId) REFERENCES Progress(id)
);

CREATE UNIQUE INDEX progressmeta_fk_name_udx ON ProgressMeta (progressId, name);