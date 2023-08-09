CREATE TABLE
  IF NOT EXISTS Example (
    -- used for integration tests
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    isExample INTEGER,
    createdAt BIGINT NOT NULL,
    updatedAt BIGINT NOT NULL
  );

CREATE UNIQUE INDEX IF NOT EXISTS example_name_udx ON Example (name);

CREATE TABLE
  IF NOT EXISTS Progress (
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

CREATE UNIQUE INDEX IF NOT EXISTS progress_uri_udx ON Progress (uri);

CREATE TABLE
  IF NOT EXISTS Tag (
    -- Tags are associated to Assets and support hierarchies.
    id INTEGER NOT NULL PRIMARY KEY,
    parentId INTEGER,
    -- this is the full path of the Tag, and is an ASCII SEP-separated string.
    _path VARCHAR(2048) NOT NULL,
    ordinal INTEGER,
    createdAt BIGINT NOT NULL,
    updatedAt BIGINT NOT NULL,
    FOREIGN KEY (parentId) REFERENCES Tag (id)
  );

CREATE UNIQUE INDEX IF NOT EXISTS tag_path_udx ON Tag (_path);

CREATE TABLE
  IF NOT EXISTS Asset -- Asset). -- heuristics (to make sure, for example, that RAW/JPEG pairs share the same -- AssetFiles. AssetFiles are coalesced with existing Assets based on Curator -- An Asset embodies an item in a library, backed by 1 or more "related"
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

CREATE TABLE
  IF NOT EXISTS AssetFile (
    -- Asset, and is the file revision that will be shown for the Asset. -- exactly one Asset. There should be only one "shown" AssetFile for a given -- An AssetFile points to a file (via the URI) and is always associated to
    id INTEGER NOT NULL PRIMARY KEY,
    assetId INTEGER NOT NULL,
    -- boolean(1 == true), true for the instance of an asset file that is shown
    -- in the UI for the given assetId
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

CREATE TABLE
  IF NOT EXISTS AssetTag (
    -- join table to associate Assets to Tags.
    assetId INTEGER NOT NULL,
    tagId INTEGER NOT NULL,
    FOREIGN KEY (assetId) REFERENCES Asset (id) ON DELETE CASCADE,
    FOREIGN KEY (tagId) REFERENCES Tag (id) ON DELETE CASCADE
  );

CREATE UNIQUE INDEX IF NOT EXISTS assettag_fks ON AssetTag (assetId, tagId);
