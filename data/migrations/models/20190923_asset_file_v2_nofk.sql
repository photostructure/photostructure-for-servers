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
  geohash INTEGER,
  meanHash VARCHAR(64),
  rightHash VARCHAR(64),
  mode8b6 INTEGER,
  version INTEGER NOT NULL DEFAULT 0,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  FOREIGN KEY (assetId) REFERENCES Asset (id)
);

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
  NULL AS make,
  NULL AS model,
  NULL AS cameraId,
  NULL AS imageId,
  NULL AS lensId,
  NULL AS geohash,
  NULL AS meanHash,
  NULL AS rightHash,
  NULL AS mode8b6,
  0 AS version,
  createdAt,
  updatedAt
FROM
  AssetFile;

DROP TABLE AssetFile;

ALTER TABLE new_AssetFile
RENAME TO AssetFile;

DROP INDEX IF EXISTS assetfile_shown_udx;

CREATE UNIQUE INDEX assetfile_shown_udx ON AssetFile (assetId)
WHERE
  shown = 1;

DROP INDEX IF EXISTS assetfile_uri_udx;

CREATE UNIQUE INDEX assetfile_uri_udx ON AssetFile (uri);

DROP INDEX IF EXISTS assetfile_capturedAtLocal_idx;

CREATE INDEX assetfile_capturedAtLocal_idx ON AssetFile (capturedAtLocal, capturedAtPrecisionMs);

DROP INDEX IF EXISTS assetfile_recent_idx;

CREATE INDEX assetfile_recent_idx ON AssetFile (updatedAt, mountpoint);

DROP INDEX IF EXISTS assetfile_sha_idx;

CREATE INDEX assetfile_sha_idx ON AssetFile (sha);

CREATE INDEX assetfile_imghash_idx ON AssetFile (meanHash, rightHash)
WHERE
  meanHash <> NULL
  AND rightHash <> NULL;
