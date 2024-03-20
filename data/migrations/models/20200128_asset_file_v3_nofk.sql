DROP TABLE IF EXISTS new_AssetFile;

CREATE TABLE new_AssetFile (
  id INTEGER NOT NULL PRIMARY KEY,
  assetId INTEGER NOT NULL,
  shown INTEGER NOT NULL DEFAULT 0,
  uri VARCHAR(2048) NOT NULL,
  mountpoint VARCHAR(1024),
  mtime INTEGER NOT NULL,
  fileSize INTEGER NOT NULL,
  mimetype VARCHAR(64) NOT NULL,
  sha VARCHAR(64) NOT NULL,
  capturedAtLocal BIGINT NOT NULL,
  capturedAtOffset INTEGER NULL,
  capturedAtPrecisionMs INTEGER NULL,
  capturedAtSrc VARCHAR(8) NOT NULL,
  focalLength VARCHAR(16),
  aperture float,
  shutterSpeed VARCHAR(16),
  iso INTEGER,
  width INTEGER,
  height INTEGER,
  rotation INTEGER,
  make VARCHAR(16),
  model VARCHAR(16),
  cameraId VARCHAR(64),
  imageId VARCHAR(64),
  lensId VARCHAR(64),
  durationMs BIGINT,
  geohash INTEGER,
  meanHash VARCHAR(64),
  rightHash VARCHAR(64),
  mode0 INTEGER,
  mode1 INTEGER,
  mode2 INTEGER,
  mode3 INTEGER,
  mode4 INTEGER,
  mode5 INTEGER,
  mode6 INTEGER,
  searchHash INTEGER,
  version INTEGER NOT NULL DEFAULT 0,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  updateCount INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY (assetId) REFERENCES Asset (id)
);

-- Moves the durationMs and mode5b10 before the version/createdAt/updatedAt, and
-- drops the mode8b6 column (which was migrated by the 20200127 migration)
INSERT INTO
  new_AssetFile
SELECT
  id,
  assetId,
  shown,
  uri,
  mountpoint,
  mtime,
  fileSize,
  mimetype,
  sha,
  capturedAtLocal,
  capturedAtOffset,
  capturedAtPrecisionMs,
  capturedAtSrc,
  focalLength,
  aperture,
  shutterSpeed,
  iso,
  width,
  height,
  rotation,
  make,
  model,
  cameraId,
  imageId,
  lensId,
  durationMs,
  geohash,
  meanHash,
  rightHash,
  mode0,
  mode1,
  mode2,
  mode3,
  mode4,
  mode5,
  mode6,
  NULL,
  version,
  createdAt,
  updatedAt,
  0
FROM
  AssetFile;

-- Drop prior indexes:
DROP INDEX IF EXISTS assetfile_capturedAtLocal_idx;

DROP INDEX IF EXISTS assetfile_imghash_idx;

DROP INDEX IF EXISTS assetfile_recent_idx;

DROP INDEX IF EXISTS assetfile_sha_idx;

DROP INDEX IF EXISTS assetfile_shown_udx;

DROP INDEX IF EXISTS assetfile_uri_udx;

-- Replace the old with the new:
DROP TABLE IF EXISTS AssetFile;

ALTER TABLE new_AssetFile
RENAME TO AssetFile;

-- Rebuild the indexes:
CREATE INDEX assetfile_capturedAtLocal_idx ON AssetFile (capturedAtLocal, capturedAtPrecisionMs);

CREATE INDEX assetfile_meanHash_idx ON AssetFile (meanHash)
WHERE
  meanHash <> NULL;

CREATE INDEX assetfile_rightHash_idx ON AssetFile (rightHash)
WHERE
  rightHash <> NULL;

CREATE INDEX assetfile_recent_idx ON AssetFile (updatedAt, mountpoint);

CREATE INDEX assetfile_sha_idx ON AssetFile (sha);

CREATE UNIQUE INDEX assetfile_shown_udx ON AssetFile (assetId, shown)
WHERE
  shown = 1;

CREATE UNIQUE INDEX assetfile_uri_udx ON AssetFile (uri);

CREATE INDEX assetfile_mode0_idx ON AssetFile (mode0);

CREATE INDEX assetfile_mode1_idx ON AssetFile (mode1);

CREATE INDEX assetfile_mode2_idx ON AssetFile (mode2);

CREATE INDEX assetfile_mode3_idx ON AssetFile (mode3);
