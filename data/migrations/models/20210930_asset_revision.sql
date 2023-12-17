DROP TABLE IF EXISTS "AssetRevision";

CREATE TABLE
  "AssetRevision" (
    -- Any change made to an Asset through the PhotoStructure UI creates an "AssetRevision" which can then be merged with any external changes made to files or sidecars.
    id INTEGER NOT NULL PRIMARY KEY,
    assetId INTEGER NOT NULL,
    createdAt BIGINT NOT NULL,
    field VARCHAR(255) NOT NULL,
    op VARCHAR(8),
    -- For singular fields, op is null.
    -- For additions to array fields (like keywords), op is "add", _priorValue is ignored, _newValue is the added keyword.
    -- For deletions to array fields (like keywords), op is "delete", _priorValue is the value to delete, and _newValue is ignored.
    _priorValueJson VARCHAR(255),
    _newValueJson VARCHAR(255),
    FOREIGN KEY (assetId) REFERENCES Asset (id)
  );
