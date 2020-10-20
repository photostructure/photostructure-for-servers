CREATE TABLE IF NOT EXISTS new_Tag -- Tags are associated to Assets and support hierarchies.
(
  id integer NOT NULL PRIMARY KEY,
  parentId integer,
  -- this is the full path of the Tag, and is an ASCII SEP-separated string.
  _path varchar (2048) NOT NULL COLLATE NOCASE,
  ordinal integer,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL,
  FOREIGN KEY(parentId) REFERENCES new_Tag(id)
);

INSERT INTO
  new_Tag
SELECT
  id,
  parentId,
  _path,
  ordinal,
  createdAt,
  updatedAt
FROM
  Tag;

-- https://www.sqlite.org/lang_altertable.html#otheralter
DROP INDEX IF EXISTS tag_path_udx;

DROP TABLE Tag;

ALTER TABLE
  new_Tag RENAME TO Tag;

CREATE UNIQUE INDEX IF NOT EXISTS tag_path_udx ON Tag (_path);