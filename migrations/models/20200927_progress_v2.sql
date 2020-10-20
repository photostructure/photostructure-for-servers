DROP TABLE IF EXISTS Progress;

DROP INDEX IF EXISTS progress_uri_udx;

CREATE TABLE Progress -- records sync process state
(
  id integer NOT NULL PRIMARY KEY,
  uri varchar (255) NOT NULL,
  hostname varchar(255) NOT NULL,
  pid bigint NOT NULL,
  volume varchar (255) NOT NULL,
  state varchar (255),
  hed varchar (255),
  dekJSON varchar (255),
  completePct integer,
  incompletePct integer,
  scanningPct integer,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL,
  completedAt bigint
);

CREATE INDEX progress_updated_at_idx ON Progress (updatedAt);