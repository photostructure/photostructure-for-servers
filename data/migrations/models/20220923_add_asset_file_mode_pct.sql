ALTER TABLE AssetFile
ADD COLUMN mode0pct INTEGER;

ALTER TABLE AssetFile
ADD COLUMN mode1pct INTEGER;

ALTER TABLE AssetFile
ADD COLUMN mode2pct INTEGER;

ALTER TABLE AssetFile
ADD COLUMN mode3pct INTEGER;

ALTER TABLE AssetFile
ADD COLUMN mode4pct INTEGER;

ALTER TABLE AssetFile
ADD COLUMN mode5pct INTEGER;

ALTER TABLE AssetFile
ADD COLUMN mode6pct INTEGER;

-- These default values are average distribution values
UPDATE AssetFile
SET
  mode0pct = 37
WHERE
  mode0 > 0;

UPDATE AssetFile
SET
  mode1pct = 26
WHERE
  mode1 > 0;

UPDATE AssetFile
SET
  mode2pct = 17
WHERE
  mode2 > 0;

UPDATE AssetFile
SET
  mode3pct = 10
WHERE
  mode3 > 0;

UPDATE AssetFile
SET
  mode4pct = 5
WHERE
  mode4 > 0;

UPDATE AssetFile
SET
  mode5pct = 2
WHERE
  mode5 > 0;

UPDATE AssetFile
SET
  mode6pct = 1
WHERE
  mode6 > 0;
