-- THERE'S AN ORDER TO THIS!
-- See https://www.sqlite.org/lang_altertable.html#otheralter
CREATE TABLE
  migrations_new (
    -- tracks database migrations applied on version upgrades
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    migration_time INTEGER NOT NULL
  ) STRICT;

INSERT INTO
  migrations_new (id, name, migration_time)
SELECT
  id,
  name,
  migration_time
FROM
  migrations;

DROP TABLE migrations;

ALTER TABLE migrations_new
RENAME TO migrations;

--------------------------------------
DROP TABLE Heartbeat;

CREATE TABLE
  Heartbeat (
    -- used for db health checks
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL
  ) STRICT;

--------------------------------------
CREATE TABLE
  Example_new (
    -- used for db health checks
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    isExample INTEGER,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL
  ) STRICT;

INSERT INTO
  Example_new (id, name, isExample, createdAt, updatedAt)
SELECT
  id,
  name,
  isExample,
  createdAt,
  updatedAt
FROM
  Example;

DROP TABLE Example;

ALTER TABLE Example_new
RENAME TO Example;

--------------------------------------
CREATE TABLE
  Session_new (
    -- used for web sessions
    sid TEXT NOT NULL PRIMARY KEY,
    expired INTEGER NOT NULL,
    sess TEXT NOT NULL
  ) STRICT;

INSERT INTO
  Session_new (sid, expired, sess)
SELECT
  sid,
  expired,
  sess
FROM
  SESSION;

DROP TABLE SESSION;

ALTER TABLE Session_new
RENAME TO 'Session';

--------------------------------------
-- Any change made to an Asset through the PhotoStructure UI creates an "AssetRevision" which can then be merged with any external changes made to files or sidecars.
CREATE TABLE
  AssetRevision_new (
    id INTEGER NOT NULL PRIMARY KEY,
    assetId INTEGER NOT NULL,
    createdAt INTEGER NOT NULL,
    field TEXT NOT NULL,
    op TEXT,
    -- For singular fields, op is null.
    -- For additions to array fields (like keywords), op is "add", _priorValue is ignored, _newValue is the added keyword.
    -- For deletions to array fields (like keywords), op is "delete", _priorValue is the value to delete, and _newValue is ignored.
    _priorValueJson TEXT,
    _newValueJson TEXT,
    FOREIGN KEY (assetId) REFERENCES Asset (id)
  ) STRICT;

INSERT INTO
  AssetRevision_new (
    id,
    assetId,
    createdAt,
    field,
    op,
    _priorValueJson,
    _newValueJson
  )
SELECT
  id,
  assetId,
  createdAt,
  field,
  op,
  _priorValueJson,
  _newValueJson
FROM
  AssetRevision;

DROP TABLE AssetRevision;

ALTER TABLE AssetRevision_new
RENAME TO AssetRevision;

--------------------------------------
DROP TABLE IF EXISTS AdvisoryLock;

--------------------------------------
CREATE TABLE
  AssetFile_new (
    -- AssetFile instances are files that back an Asset.
    id INTEGER NOT NULL PRIMARY KEY,
    assetId INTEGER NOT NULL,
    shown INTEGER NOT NULL DEFAULT 0,
    uri TEXT NOT NULL,
    mountpoint TEXT,
    mtime INTEGER NOT NULL,
    fileSize INTEGER NOT NULL,
    mimetype TEXT NOT NULL,
    sha TEXT NOT NULL,
    capturedAtLocal INTEGER NOT NULL,
    capturedAtOffset INTEGER NULL,
    capturedAtPrecisionMs INTEGER NULL,
    capturedAtSrc TEXT NOT NULL,
    focalLength TEXT,
    aperture REAL,
    shutterSpeed TEXT,
    iso INTEGER,
    width INTEGER,
    height INTEGER,
    rotation INTEGER,
    make TEXT,
    model TEXT,
    cameraId TEXT,
    imageId TEXT,
    lensId TEXT,
    durationMs INTEGER,
    fps INTEGER,
    geohash INTEGER,
    meanHash TEXT,
    mode0 INTEGER,
    mode1 INTEGER,
    mode2 INTEGER,
    mode3 INTEGER,
    mode4 INTEGER,
    mode5 INTEGER,
    mode6 INTEGER,
    version INTEGER NOT NULL DEFAULT 0,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL,
    updateCount INTEGER NOT NULL DEFAULT 0,
    rating INTEGER,
    mode0pct INTEGER,
    mode1pct INTEGER,
    mode2pct INTEGER,
    mode3pct INTEGER,
    mode4pct INTEGER,
    mode5pct INTEGER,
    mode6pct INTEGER,
    dctHash TEXT,
    diffHash TEXT,
    FOREIGN KEY (assetId) REFERENCES Asset (id)
  ) STRICT;

INSERT INTO
  AssetFile_new (
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
    fps,
    geohash,
    meanHash,
    mode0,
    mode1,
    mode2,
    mode3,
    mode4,
    mode5,
    mode6,
    version,
    createdAt,
    updatedAt,
    updateCount,
    rating,
    mode0pct,
    mode1pct,
    mode2pct,
    mode3pct,
    mode4pct,
    mode5pct,
    mode6pct,
    dctHash,
    diffHash
  )
SELECT
  id,
  assetId,
  shown,
  uri,
  mountpoint,
  FLOOR(mtime),
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
  fps,
  geohash,
  meanHash,
  mode0,
  mode1,
  mode2,
  mode3,
  mode4,
  mode5,
  mode6,
  version,
  createdAt,
  updatedAt,
  updateCount,
  rating,
  mode0pct,
  mode1pct,
  mode2pct,
  mode3pct,
  mode4pct,
  mode5pct,
  mode6pct,
  dctHash,
  diffHash
FROM
  AssetFile;

DROP TABLE AssetFile;

ALTER TABLE AssetFile_new
RENAME TO AssetFile;

--------------------------------------
CREATE TABLE
  AssetTag_new (
    -- join table to associate Assets to Tags.
    assetId INTEGER NOT NULL,
    tagId INTEGER NOT NULL,
    FOREIGN KEY (assetId) REFERENCES Asset (id) ON DELETE CASCADE,
    FOREIGN KEY (tagId) REFERENCES Tag (id) ON DELETE CASCADE
  ) STRICT;

INSERT INTO
  AssetTag_new (assetId, tagId)
SELECT
  assetId,
  tagId
FROM
  AssetTag;

DROP TABLE AssetTag;

ALTER TABLE AssetTag_new
RENAME TO AssetTag;

--------------------------------------
CREATE TABLE
  ProgressMeta_new (
    -- Used to store state of a sync. Prevents future sync jobs from re-doing prior work.
    id INTEGER NOT NULL PRIMARY KEY,
    progressId INTEGER NOT NULL,
    name TEXT NOT NULL,
    value TEXT NOT NULL,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL,
    FOREIGN KEY (progressId) REFERENCES Progress (id)
  ) STRICT;

INSERT INTO
  ProgressMeta_new (id, progressId, name, value, createdAt, updatedAt)
SELECT
  id,
  progressId,
  name,
  value,
  createdAt,
  updatedAt
FROM
  ProgressMeta;

DROP TABLE ProgressMeta;

ALTER TABLE ProgressMeta_new
RENAME TO ProgressMeta;

--------------------------------------
CREATE TABLE
  Progress_new (
    -- records sync process state
    id INTEGER NOT NULL PRIMARY KEY,
    uri TEXT NOT NULL,
    hostname TEXT NOT NULL,
    pid INTEGER NOT NULL,
    volume TEXT NOT NULL,
    state TEXT,
    hed TEXT,
    dekJSON TEXT,
    completePct INTEGER,
    incompletePct INTEGER,
    scanningPct INTEGER,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL,
    completedAt INTEGER
  ) STRICT;

INSERT INTO
  Progress_new (
    id,
    uri,
    hostname,
    pid,
    volume,
    state,
    hed,
    dekJSON,
    completePct,
    incompletePct,
    scanningPct,
    createdAt,
    updatedAt,
    completedAt
  )
SELECT
  id,
  uri,
  hostname,
  pid,
  volume,
  state,
  hed,
  dekJSON,
  completePct,
  incompletePct,
  scanningPct,
  createdAt,
  updatedAt,
  completedAt
FROM
  Progress;

DROP TABLE Progress;

ALTER TABLE Progress_new
RENAME TO Progress;

--------------------------------------
CREATE TABLE
  Operation_new (
    -- used to store user-requested operations, like "forced" syncs
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    value TEXT,
    version INTEGER,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL,
    completedAt INTEGER
  ) STRICT;

INSERT INTO
  Operation_new (
    id,
    name,
    value,
    version,
    createdAt,
    updatedAt,
    completedAt
  )
SELECT
  id,
  name,
  value,
  version,
  createdAt,
  updatedAt,
  completedAt
FROM
  Operation;

DROP TABLE Operation;

ALTER TABLE Operation_new
RENAME TO Operation;

--------------------------------------
CREATE TABLE
  ShaBlocklist_new (
    -- Files with any of these SHAs are not to be imported.
    sha TEXT NOT NULL PRIMARY KEY
  ) STRICT;

INSERT INTO
  ShaBlocklist_new (sha)
SELECT
  sha
FROM
  ShaBlocklist;

DROP TABLE ShaBlocklist;

ALTER TABLE ShaBlocklist_new
RENAME TO ShaBlocklist;

--------------------------------------
DROP TABLE ChangedTag;

--------------------------------------
CREATE TABLE
  Asset_new (
    -- an "asset" is a photos or video, backed by 1 or more asset file variations.
    id INTEGER NOT NULL PRIMARY KEY,
    capturedAtLocal INTEGER NOT NULL,
    shown INTEGER NOT NULL DEFAULT 0,
    hidden INTEGER NOT NULL DEFAULT 0,
    rating INTEGER DEFAULT 0,
    version INTEGER NOT NULL DEFAULT 0,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL,
    updateCount INTEGER NOT NULL DEFAULT 0,
    deletedAt INTEGER,
    durationMs INTEGER,
    excludedAt INTEGER
  ) STRICT;

INSERT INTO
  Asset_new (
    id,
    capturedAtLocal,
    shown,
    hidden,
    rating,
    version,
    createdAt,
    updatedAt,
    updateCount,
    deletedAt,
    durationMs,
    excludedAt
  )
SELECT
  id,
  capturedAtLocal,
  shown,
  hidden,
  rating,
  version,
  createdAt,
  updatedAt,
  updateCount,
  deletedAt,
  durationMs,
  excludedAt
FROM
  Asset;

DROP TABLE Asset;

ALTER TABLE Asset_new
RENAME TO Asset;

--------------------------------------
CREATE TABLE
  Tag_new (
    -- tags are hierarchical. Root tags have a null parentId. Assets can have zero or more tags.
    id INTEGER NOT NULL PRIMARY KEY,
    parentId INTEGER,
    -- this is the full path of the Tag, and is an ASCII SEP-separated string.
    _path TEXT NOT NULL COLLATE NOCASE,
    ordinal INTEGER,
    createdAt INTEGER NOT NULL,
    updatedAt INTEGER NOT NULL,
    assetCount INTEGER DEFAULT 0,
    _displayName TEXT,
    description TEXT,
    releasedAt INTEGER,
    FOREIGN KEY (parentId) REFERENCES Tag (id)
  ) STRICT;

INSERT INTO
  Tag_new (
    id,
    parentId,
    _path,
    ordinal,
    createdAt,
    updatedAt,
    assetCount,
    _displayName,
    description,
    releasedAt
  )
SELECT
  id,
  parentId,
  _path,
  ordinal,
  createdAt,
  updatedAt,
  assetCount,
  _displayName,
  description,
  releasedAt
FROM
  Tag;

DROP TABLE Tag;

ALTER TABLE Tag_new
RENAME TO Tag;

--------------------------------------
-- Re-establish all indexes:
DROP INDEX IF EXISTS example_name_udx;

CREATE UNIQUE INDEX example_name_udx ON Example (name);

DROP INDEX IF EXISTS assettag_fks;

CREATE UNIQUE INDEX assettag_fks ON AssetTag (assetId, tagId);

DROP INDEX IF EXISTS heartbeat_name_udx;

CREATE UNIQUE INDEX heartbeat_name_udx ON Heartbeat (name);

DROP INDEX IF EXISTS lock_name_lockId_udx;

DROP INDEX IF EXISTS lock_acquired_udx;

DROP INDEX IF EXISTS assetfile_capturedAtLocal_idx;

CREATE INDEX assetfile_capturedAtLocal_idx ON AssetFile (capturedAtLocal, capturedAtPrecisionMs);

DROP INDEX IF EXISTS assetfile_meanHash_idx;

CREATE INDEX assetfile_meanHash_idx ON AssetFile (meanHash)
WHERE
  meanHash <> NULL;

DROP INDEX IF EXISTS assetfile_recent_idx;

CREATE INDEX assetfile_recent_idx ON AssetFile (updatedAt, mountpoint);

DROP INDEX IF EXISTS assetfile_sha_idx;

CREATE INDEX assetfile_sha_idx ON AssetFile (sha);

DROP INDEX IF EXISTS assetfile_shown_udx;

CREATE UNIQUE INDEX assetfile_shown_udx ON AssetFile (assetId, shown)
WHERE
  shown = 1;

DROP INDEX IF EXISTS assetfile_uri_udx;

CREATE UNIQUE INDEX assetfile_uri_udx ON AssetFile (uri);

DROP INDEX IF EXISTS assetfile_mode0_idx;

DROP INDEX IF EXISTS assetfile_mode1_idx;

DROP INDEX IF EXISTS assetfile_mode2_idx;

CREATE INDEX assetfile_mode_idx ON AssetFile (mode0, mode1, mode2);

DROP INDEX IF EXISTS tag_path_udx;

CREATE UNIQUE INDEX tag_path_udx ON Tag (_path);

DROP INDEX IF EXISTS progress_updated_at_idx;

CREATE INDEX progress_updated_at_idx ON Progress (updatedAt);

DROP INDEX IF EXISTS progressmeta_fk_name_udx;

CREATE UNIQUE INDEX progressmeta_fk_name_udx ON ProgressMeta (progressId, name);

DROP INDEX IF EXISTS asset_cap_idx;

CREATE INDEX asset_cap_idx ON Asset (capturedAtLocal, rating)
WHERE
  shown = 1
  AND hidden = 0
  AND excludedAt IS NULL
  AND deletedAt IS NULL;

DROP INDEX IF EXISTS asset_excludedAt_idx;

CREATE INDEX asset_excludedAt_idx ON Asset (excludedAt)
WHERE
  excludedAt IS NOT NULL;

DROP INDEX IF EXISTS asset_deletedAt_idx;

CREATE INDEX asset_deletedAt_idx ON Asset (deletedAt)
WHERE
  deletedAt IS NOT NULL;
