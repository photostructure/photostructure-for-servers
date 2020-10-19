CREATE TABLE IF NOT EXISTS Heartbeat -- used for db health checks
(
  id integer NOT NULL PRIMARY KEY,
  name varchar (255) NOT NULL,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS heartbeat_name_udx ON Heartbeat (name);