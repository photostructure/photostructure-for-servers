DROP INDEX IF EXISTS asset_cap_idx;

ALTER TABLE Asset DROP COLUMN excluded;
ALTER TABLE Asset ADD COLUMN excludedAt bigint;

-- View shown assets by captured-at
CREATE INDEX asset_cap_idx ON Asset (capturedAtLocal, rating)
WHERE
  shown = 1
  AND hidden = 0
  AND excludedAt IS NULL
  AND deletedAt IS NULL;

CREATE INDEX asset_excludedAt_idx ON Asset (excludedAt)
WHERE
  excludedAt IS NOT NULL