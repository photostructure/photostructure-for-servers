ALTER TABLE
  Asset
ADD
  COLUMN excluded integer NOT NULL DEFAULT 0;

-- todo: remove "Asset.favorite"
DROP INDEX IF EXISTS asset_cap_idx;

CREATE INDEX asset_cap_idx ON Asset (capturedAtLocal)
WHERE
  shown = 1
  AND hidden = 0
  AND excluded = 0;