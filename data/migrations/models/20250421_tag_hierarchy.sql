CREATE TABLE TagHierarchy -- join table to associate descendant and ancestor Tags.
(
  tagId INTEGER NOT NULL,
  descendantId INTEGER NOT NULL,
  depth INTEGER NOT NULL,
  PRIMARY KEY (tagId, descendantId),
  FOREIGN KEY (tagId) REFERENCES Tag (id) ON DELETE CASCADE,
  FOREIGN KEY (descendantId) REFERENCES Tag (id) ON DELETE CASCADE
) STRICT;

CREATE INDEX IF NOT EXISTS TagHierarchy_descendantId_depth_idx ON TagHierarchy (descendantId, depth);

CREATE INDEX IF NOT EXISTS TagHierarchy_tagId_depth_idx ON TagHierarchy (tagId, depth);
