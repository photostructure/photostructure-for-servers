CREATE TABLE
  Operation (
    -- used to store user-requested operations, like "forced" syncs
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    value VARCHAR(255),
    version BIGINT,
    createdAt BIGINT NOT NULL,
    updatedAt BIGINT NOT NULL,
    completedAt BIGINT
  );
