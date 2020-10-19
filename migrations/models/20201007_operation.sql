CREATE TABLE Operation -- used to store user-requested operations, like "forced" syncs
(
  id integer NOT NULL PRIMARY KEY,
  name varchar(255) NOT NULL,
  value varchar(255),
  version bigint,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL,
  completedAt bigint
);