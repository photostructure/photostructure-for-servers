DROP TABLE IF EXISTS QueueItem;
DROP TABLE IF EXISTS Queue;

CREATE TABLE Queue (
  id integer NOT NULL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE UNIQUE INDEX queue_name_udx on Queue( name );

CREATE TABLE QueueItem (
  id integer NOT NULL PRIMARY KEY,
  queueId integer NOT NULL,
  contents TEXT NOT NULL,
  type TEXT,
  FOREIGN KEY(queueId) REFERENCES Queue(id)
);

CREATE UNIQUE INDEX queue_item_contents_udx on QueueItem( contents );

CREATE INDEX queue_item_type_idx on QueueItem( queueId, id, type );