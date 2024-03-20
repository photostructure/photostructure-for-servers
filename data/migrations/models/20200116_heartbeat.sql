CREATE TABLE IF NOT EXISTS Heartbeat -- used for db health checks
(
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS heartbeat_name_udx ON Heartbeat (name);
