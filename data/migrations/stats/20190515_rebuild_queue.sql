DROP TABLE IF EXISTS QueueItem;

DROP TABLE IF EXISTS Queue;

CREATE TABLE
  Queue (
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
  );

CREATE UNIQUE INDEX queue_name_udx ON Queue (name);

CREATE TABLE
  QueueItem (
    id INTEGER NOT NULL PRIMARY KEY,
    queueId INTEGER NOT NULL,
    contents TEXT NOT NULL,
    type TEXT,
    FOREIGN KEY (queueId) REFERENCES Queue (id)
  );

CREATE UNIQUE INDEX queue_item_contents_udx ON QueueItem (queueId, contents);

CREATE INDEX queue_item_type_idx ON QueueItem (queueId, id, TYPE);
