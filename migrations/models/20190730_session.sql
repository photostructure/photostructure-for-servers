CREATE TABLE IF NOT EXISTS SESSION (
  sid varchar (255) NOT NULL PRIMARY KEY,
  expired bigint NOT NULL,
  sess varchar (2048) NOT NULL
);