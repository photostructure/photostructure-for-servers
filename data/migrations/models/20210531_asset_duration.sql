-- Mea culpa: I'm denormalizing AssetFile.durationMs into Asset to simplify
-- queries:
ALTER TABLE Asset
ADD COLUMN durationMs BIGINT;

UPDATE Asset
SET
  durationMs = src.durationMs
FROM
  (
    SELECT
      assetId,
      durationMs
    FROM
      AssetFile
    WHERE
      shown = 1
  ) AS src
WHERE
  Asset.id = src.assetId;
