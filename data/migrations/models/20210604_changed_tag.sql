CREATE TABLE
  ChangedTag (
    -- used to store tags that have assets added or removed (and need their assets re-counted)
    tagId ID INTEGER NOT NULL PRIMARY KEY,
    FOREIGN KEY (tagId) REFERENCES Tag (id) ON DELETE CASCADE
  );
