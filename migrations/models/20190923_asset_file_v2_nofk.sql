CREATE TABLE new_AssetFile 
(
  id integer NOT NULL PRIMARY KEY,
  assetId integer NOT NULL,
  shown integer NOT NULL DEFAULT 0,
  uri varchar ( 2048 ) NOT NULL,
  mountpoint varchar ( 1024 ),
  mtime integer NOT NULL,
  fileSize integer NOT NULL,
  mimetype varchar ( 64 ) NOT NULL,
  sha varchar ( 64 ) NOT NULL,
  capturedAtLocal bigint NOT NULL,
  capturedAtOffset integer NULL,
  capturedAtPrecisionMs integer NULL,
  capturedAtSrc varchar ( 8 ) NOT NULL,
  focalLength varchar ( 16 ),
  aperture float,
  shutterSpeed varchar ( 16 ),
  iso integer,
  width integer,
  height integer,
  rotation integer,
  make varchar ( 16 ),
  model varchar ( 16 ),
  cameraId varchar ( 64 ),
  imageId varchar ( 64 ),
  lensId varchar ( 64 ),
  geohash integer,
  meanHash varchar ( 64 ),
  rightHash varchar ( 64 ),
  mode8b6 integer,
  version integer NOT NULL DEFAULT 0,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL,
  FOREIGN KEY(assetId) REFERENCES Asset(id)
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
  NULL as make,
  NULL as model,
  NULL as cameraId,
  NULL as imageId,
  NULL as lensId,
  NULL as geohash,
  NULL as meanHash,
  NULL as rightHash,
  NULL as mode8b6,
  0 as version,
  createdAt,
  updatedAt
FROM
  AssetFile;

DROP TABLE AssetFile;
ALTER TABLE new_AssetFile RENAME TO AssetFile;

DROP INDEX IF EXISTS assetfile_shown_udx;
CREATE UNIQUE INDEX assetfile_shown_udx ON AssetFile ( assetId ) WHERE shown = 1;

DROP INDEX IF EXISTS assetfile_uri_udx;
CREATE UNIQUE INDEX assetfile_uri_udx ON AssetFile ( uri );

DROP INDEX IF EXISTS assetfile_capturedAtLocal_idx;
CREATE INDEX assetfile_capturedAtLocal_idx ON AssetFile ( capturedAtLocal,capturedAtPrecisionMs );

DROP INDEX IF EXISTS assetfile_recent_idx;
CREATE INDEX assetfile_recent_idx ON AssetFile ( updatedAt, mountpoint );

DROP INDEX IF EXISTS assetfile_sha_idx;
CREATE INDEX assetfile_sha_idx ON AssetFile ( sha ) ;

CREATE INDEX assetfile_imghash_idx on AssetFile ( meanHash, rightHash ) WHERE meanHash <> NULL AND rightHash <> NULL;
