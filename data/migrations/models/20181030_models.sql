DROP INDEX IF EXISTS example_name_udx;

DROP TABLE IF EXISTS Example;

CREATE TABLE Example -- used for integration tests
(
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  isExample INTEGER,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL
);

CREATE UNIQUE INDEX example_name_udx ON Example (name);

DROP INDEX IF EXISTS progress_uri_udx;

DROP TABLE IF EXISTS Progress;

CREATE TABLE Progress (
  -- records sync process state
  id INTEGER NOT NULL PRIMARY KEY,
  uri VARCHAR(255) NOT NULL,
  volume VARCHAR(255) NOT NULL,
  state VARCHAR(255),
  hed VARCHAR(255),
  dekJSON VARCHAR(255),
  completePct INTEGER,
  incompletePct INTEGER,
  scanningPct INTEGER,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL
);

CREATE UNIQUE INDEX progress_uri_udx ON Progress (uri);

DROP INDEX IF EXISTS tag_path_udx;

DROP TABLE IF EXISTS Tag;

CREATE TABLE Tag -- Tags are associated to Assets and support hierarchies.
(
  id INTEGER NOT NULL PRIMARY KEY,
  parentId INTEGER,
  -- this is the full path of the Tag, and is an ASCII SEP-separated string.
  _path VARCHAR(2048) NOT NULL,
  ordinal INTEGER,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  FOREIGN KEY (parentId) REFERENCES Tag (id)
);

CREATE UNIQUE INDEX tag_path_udx ON Tag (_path);

DROP INDEX IF EXISTS asset_timeline;

DROP INDEX IF EXISTS assetfile_uri_udx;

DROP INDEX IF EXISTS assetfile_recent_idx;

DROP INDEX IF EXISTS assetfile_sha_idx;

DROP INDEX IF EXISTS assetfile_exifuid_idx;

DROP INDEX IF EXISTS assetfile_shown_udx;

DROP TABLE IF EXISTS Asset;

DROP TABLE IF EXISTS AssetFile;

CREATE TABLE Asset -- An Asset embodies a photo or video in a library, backed by 1 or more AssetFile rows
(
  id INTEGER NOT NULL PRIMARY KEY,
  -- true if the asset *can* be shown
  shown INTEGER NOT NULL DEFAULT 0,
  -- hidden is only set to true by the user
  hidden INTEGER NOT NULL DEFAULT 0,
  description VARCHAR(512),
  geohash BIGINT,
  capturedAt BIGINT NOT NULL,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL
);

CREATE INDEX IF NOT EXISTS asset_timeline ON Asset (capturedAt)
WHERE
  shown = 1
  AND hidden = 0;

CREATE TABLE IF NOT EXISTS AssetFile -- An AssetFile is a file on disk that is associated with an Asset.
(
  id INTEGER NOT NULL PRIMARY KEY,
  assetId INTEGER NOT NULL,
  -- 1 if the asset file is the primary file to be shown for the asset
  shown INTEGER NOT NULL DEFAULT 0,
  -- May be longer than 1 K as this is the full native path to files:
  uri VARCHAR(2048) NOT NULL,
  -- The mountpoint is encoded in the uri, but if it goes missing, this allows
  -- the URI to be reconstituted as a full native path.
  mountpoint VARCHAR(2048),
  mimetype VARCHAR(64) NOT NULL,
  sha VARCHAR(64) NOT NULL,
  exifUid VARCHAR(255),
  -- This is the ISO-encoded datestamp of when this AssetFile was captured. This
  -- may not have a timezone offset, nor have time resolution at all. It may be
  -- an interval string if the value is interpolated from siblings.
  capturedAtISO VARCHAR(64),
  -- As capturedAt may be inferred, this holds the name of the inferral function
  -- that generated the capturedAt.
  capturedAtSrc VARCHAR(8),
  focalLength VARCHAR(16),
  aperture FLOAT,
  shutterSpeed VARCHAR(16),
  iso INTEGER,
  width INTEGER,
  height INTEGER,
  -- mtime and fileSize is used to quickly pre-check if a file has been updated
  -- (rather than reading the entire contents of the file and comparing SHAs)
  mtime INTEGER NOT NULL,
  fileSize INTEGER NOT NULL,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  FOREIGN KEY (assetId) REFERENCES Asset (id)
);

CREATE UNIQUE INDEX IF NOT EXISTS assetfile_uri_udx ON AssetFile (uri);

CREATE INDEX IF NOT EXISTS assetfile_recent_idx ON AssetFile (updatedAt, mountpoint);

CREATE INDEX IF NOT EXISTS assetfile_sha_idx ON AssetFile (sha);

CREATE INDEX IF NOT EXISTS assetfile_exifuid_idx ON AssetFile (exifUid);

-- Only allow one shown asset file per asset:
CREATE UNIQUE INDEX IF NOT EXISTS assetfile_shown_udx ON AssetFile (assetId)
WHERE
  shown = 1;

DROP TABLE IF EXISTS AssetTag;

DROP INDEX IF EXISTS assettag_fks;

CREATE TABLE AssetTag -- join table to associate Assets to Tags.
(
  assetId INTEGER NOT NULL,
  tagId INTEGER NOT NULL,
  FOREIGN KEY (assetId) REFERENCES Asset (id) ON DELETE CASCADE,
  FOREIGN KEY (tagId) REFERENCES Tag (id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS assettag_fks ON AssetTag (assetId, tagId);
