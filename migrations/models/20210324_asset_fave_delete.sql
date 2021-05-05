ALTER TABLE
  Asset RENAME COLUMN favorite to rating;

ALTER TABLE
  Asset
ADD
  COLUMN deletedAt bigint;

DROP INDEX IF EXISTS asset_cap_idx;

-- View shown assets by captured-at
CREATE INDEX asset_cap_idx ON Asset (capturedAtLocal, rating)
WHERE
  shown = 1
  AND excluded = 0
  AND hidden = 0
  AND deletedAt IS NULL;

-- Support for showing only deleted assets:
CREATE INDEX asset_deletedAt_idx ON Asset (deletedAt)
WHERE
  deletedAt IS NOT NULL;