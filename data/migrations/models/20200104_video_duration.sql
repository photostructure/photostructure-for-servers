ALTER TABLE AssetFile
ADD COLUMN durationMs BIGINT;

-- Revisit the video AssetFiles:
UPDATE AssetFile
SET
  version = 0
WHERE
  mimetype LIKE 'video/%';
