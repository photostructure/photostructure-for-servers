CREATE TABLE IF NOT EXISTS Example 
-- used for integration tests and runtime health checks
(
  id integer NOT NULL PRIMARY KEY,
  name varchar ( 255 ) NOT NULL,
  isExample integer,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS example_name_udx ON Example (
  name
);

CREATE TABLE IF NOT EXISTS Progress 
-- records sync process state
(
  id integer NOT NULL PRIMARY KEY,
  uri varchar ( 255 ) NOT NULL,
  volume varchar ( 255 ) NOT NULL,
  state varchar ( 255 ),
  hed varchar ( 255 ),
  dekJSON varchar ( 255 ),
  completePct integer,
  incompletePct integer,
  scanningPct integer,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS progress_uri_udx ON Progress (
  uri
);

CREATE TABLE IF NOT EXISTS Tag 
-- Tags are associated to Assets and support hierarchies.
(
  id integer NOT NULL PRIMARY KEY,
  parentId integer,
  -- this is the full path of the Tag, and is an ASCII SEP-separated string.
  _path varchar ( 2048 ) NOT NULL,
  ordinal integer,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL,
  FOREIGN KEY(parentId) REFERENCES Tag(id)
);

CREATE UNIQUE INDEX IF NOT EXISTS tag_path_udx ON Tag (
  _path
);

CREATE TABLE IF NOT EXISTS Asset 
-- An Asset embodies an item in a library, backed by 1 or more "related"
-- AssetFiles. AssetFiles are coalesced with existing Assets based on Curator
-- heuristics (to make sure, for example, that RAW/JPEG pairs share the same
-- Asset).
(
  id integer NOT NULL PRIMARY KEY,
  -- true if the asset *can* be shown
  shown integer NOT NULL DEFAULT 0,
  -- hidden is only set to true by the user
  hidden integer NOT NULL DEFAULT 0,
  description varchar ( 512 ),
  geohash bigint,
  capturedAt bigint NOT NULL,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL
);

CREATE INDEX IF NOT EXISTS asset_timeline ON Asset (
  capturedAt
) WHERE shown = 1 AND hidden = 0;

CREATE TABLE IF NOT EXISTS AssetFile 
-- An AssetFile points to a file (via the URI) and is always associated to
-- exactly one Asset. There should be only one "shown" AssetFile for a given
-- Asset, and is the file revision that will be shown for the Asset.
(
  id integer NOT NULL PRIMARY KEY,
  assetId integer NOT NULL,
  -- boolean (1 == true), true for the instance of an asset file that is shown
  -- in the UI for the given assetId
  shown integer NOT NULL DEFAULT 0,
  -- May be longer than 1 K as this is the full native path to files:
  uri varchar ( 2048 ) NOT NULL,
  -- The mountpoint is encoded in the uri, but if it goes missing, this allows
  -- the URI to be reconstituted as a full native path.
  mountpoint varchar ( 2048 ),
  mimetype varchar ( 64 ) NOT NULL,
  sha varchar ( 64 ) NOT NULL,
  exifUid varchar ( 255 ),
  -- This is the ISO-encoded datestamp of when this AssetFile was captured. This
  -- may not have a timezone offset, nor have time resolution at all. It may be
  -- an interval string if the value is interpolated from siblings.
  capturedAtISO varchar ( 64 ),
  -- As capturedAt may be inferred, this holds the name of the inferral function
  -- that generated the capturedAt.
  capturedAtSrc varchar ( 8 ),
  focalLength varchar ( 16 ),
  aperture float,
  shutterSpeed varchar ( 16 ),
  iso integer,
  width integer,
  height integer,
  -- mtime and fileSize is used to quickly pre-check if a file has been updated
  -- (rather than reading the entire contents of the file and comparing SHAs)
  mtime integer NOT NULL,
  fileSize integer NOT NULL,
  createdAt bigint NOT NULL,
  updatedAt bigint NOT NULL,
  FOREIGN KEY(assetId) REFERENCES Asset(id)
);

CREATE UNIQUE INDEX IF NOT EXISTS assetfile_uri_udx ON AssetFile (
  uri
);

CREATE INDEX IF NOT EXISTS assetfile_recent_idx ON AssetFile (
  updatedAt, mountpoint
);

CREATE INDEX IF NOT EXISTS assetfile_sha_idx ON AssetFile (
  sha
);

CREATE INDEX IF NOT EXISTS assetfile_exifuid_idx ON AssetFile (
  exifUid
);

-- Only allow one shown asset file per asset: 
CREATE UNIQUE INDEX IF NOT EXISTS assetfile_shown_udx ON AssetFile (
  assetId
) WHERE shown = 1;

CREATE TABLE IF NOT EXISTS AssetTag (
  assetId integer NOT NULL,
  tagId integer NOT NULL,
  FOREIGN KEY(assetId) REFERENCES Asset(id) on delete CASCADE,
  FOREIGN KEY(tagId) REFERENCES Tag(id) on delete CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS assettag_fks ON AssetTag (
  assetId,
  tagId
);
