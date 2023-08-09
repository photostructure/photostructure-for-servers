CREATE TABLE
  IF NOT EXISTS MergedAsset (
    -- When Exif UIDs are updated (like v5) and previously-separated assets are
    -- merged, this table stores those redirections. 
    -- id is the "merge victim", the asset id that doesn't exist anymore.
    id INTEGER NOT NULL PRIMARY KEY,
    -- assetId is the "merge victor", the asset that currently exists and subsumed the prior asset.
    assetId INTEGER NOT NULL,
    FOREIGN KEY (assetId) REFERENCES Asset (id)
  );
