-- Tables will be backfilled by 20250423_schema_v3_backfill.sql.
--
-- See https://www.sqlite.org/lang_altertable.html#otheralter
--------------------------------------
-- Create normalized URI storage tables
--------------------------------------
DROP TABLE IF EXISTS Volume;

-- Backstop for resolving URIs when volumes aren't mounted. No foreign keys
-- reference this table - pslib:// and file:// URIs have no volsha, and
-- psfile:// URIs resolve via the most recently seen mountpoint for their authority.
CREATE TABLE Volume (
  id INTEGER PRIMARY KEY,
  authority TEXT NOT NULL, -- aka "volsha"
  mountPoint TEXT NOT NULL,
  lastSeenAt INTEGER NOT NULL -- epoch ms when volume was last mounted/scanned
) STRICT;

CREATE UNIQUE INDEX IF NOT EXISTS Volume_authority_mountpoint_udx ON Volume (authority, mountPoint);

DROP TABLE IF EXISTS DirUri;

-- This normalizes the URIs we store -- AssetFiles just need to store their
-- parent's URI and their basename. We _could_ have stored normalized paths with
-- recursive parent id references, and that would indeed be the most storage
-- efficient, but let's not require us to use SQLite recursion CTE syntax if we
-- don't absolutely need to.
CREATE TABLE DirUri (
  id INTEGER NOT NULL PRIMARY KEY,
  uri TEXT NOT NULL -- The directory part of a URI (e.g., "psfile://abc123/path/to/")
) STRICT;

CREATE UNIQUE INDEX IF NOT EXISTS DirUri_uri_udx ON DirUri (uri);

--------------------------------------
-- Create enhanced Asset table with promoted metadata from AssetFile
--------------------------------------
DROP TABLE IF EXISTS Asset_new;

CREATE TABLE Asset_new (
  id INTEGER NOT NULL PRIMARY KEY,
  shown INTEGER NOT NULL DEFAULT 0, -- 0 means work-in-progress
  hidden INTEGER NOT NULL DEFAULT 0, -- hidden by the user
  -- materialized from the primary assetFile
  capturedAtLocal INTEGER NOT NULL, -- used for sorting
  mimetype TEXT NOT NULL, -- used as filter
  rating INTEGER, -- used as filter
  durationMs INTEGER, -- used in UI
  -- bookkeeping:
  flags INTEGER,
  deletedAt INTEGER,
  excludedAt INTEGER,
  createdAt INTEGER NOT NULL,
  updatedAt INTEGER NOT NULL,
  updateCount INTEGER NOT NULL DEFAULT 0 -- used for client-side cache invalidation. TODO: replace with updatedAt via ETAGS?
) STRICT;

DROP TABLE IF EXISTS AssetFile_new;

--------------------------------------
-- AssetFile table now supports "orphans" (to-be-aggregated rows) and new image
-- hash algorithms
--------------------------------------
CREATE TABLE AssetFile_new (
  id INTEGER NOT NULL PRIMARY KEY,
  dirUriId INTEGER NOT NULL REFERENCES DirUri (id),
  basename TEXT NOT NULL, -- Just the filename portion of the URI
  assetId INTEGER REFERENCES Asset_new (id), -- null means orphan
  isPrimary INTEGER NOT NULL DEFAULT 0,
  -- quick no-op fields
  mtime INTEGER NOT NULL,
  fileSize INTEGER NOT NULL,
  -- primary metadata
  mimetype TEXT NOT NULL,
  width INTEGER NOT NULL, -- Required for AssetFile comparison
  height INTEGER NOT NULL, -- Required for AssetFile comparison
  rotation INTEGER, -- Required for AssetFile comparison
  durationMs INTEGER,
  -- aggregation fields
  cameraId TEXT, -- TODO: normalize?
  lensId TEXT, -- TODO: normalize?
  imageDataHash TEXT,
  imageId TEXT,
  metadataDate INTEGER, -- last metadata edit timestamp, millis from common epoch
  sha TEXT NOT NULL,
  -- captured at:
  capturedAtLocal INTEGER NOT NULL,
  capturedAtPrecisionMs INTEGER,
  capturedAtZone TEXT,
  capturedAtSrc TEXT,
  -- asset info panel:
  make TEXT,
  model TEXT,
  rating INTEGER,
  aperture REAL,
  focalLength TEXT, -- although always in mm, we use string to retain precision
  fps REAL,
  geohash INTEGER,
  iso INTEGER,
  shutterSpeed TEXT, -- _actually_ store "1/250"
  -- image hash fields:
  monochrome INTEGER,
  -- aHash TEXT,
  -- dHash TEXT,
  -- vHash TEXT,
  pHash TEXT,
  rHash TEXT,
  wHash TEXT,
  pHash0 TEXT,
  rHash0 TEXT,
  wHash0 TEXT,
  -- bookkeeping:
  flags INTEGER,
  createdAt INTEGER NOT NULL,
  updatedAt INTEGER NOT NULL,
  updateCount INTEGER NOT NULL DEFAULT 0 -- used for cache invalidation. TODO: replace with updatedAt via ETAGS?
) STRICT;

--------------------------------------
-- Drop and recreate Asset indexes
--------------------------------------
DROP INDEX IF EXISTS asset_cap_idx;

DROP INDEX IF EXISTS asset_deletedAt_idx;

DROP INDEX IF EXISTS asset_excludedAt_idx;

--------------------------------------
-- Drop and recreate AssetFile indexes
--------------------------------------
DROP INDEX IF EXISTS assetfile_capturedAtLocal_idx;

DROP INDEX IF EXISTS assetfile_meanHash_idx;

DROP INDEX IF EXISTS assetfile_mode0_idx;

DROP INDEX IF EXISTS assetfile_mode1_idx;

DROP INDEX IF EXISTS assetfile_mode2_idx;

DROP INDEX IF EXISTS assetfile_recent_idx;

DROP INDEX IF EXISTS assetfile_sha_idx;

DROP INDEX IF EXISTS assetfile_shown_udx;

DROP INDEX IF EXISTS assetfile_uri_udx;

-- For the files that pass the cheap filters, but are rejected by the expensive
-- filters, this table allows subsequent `sync` runs to skip those expensive
-- filters. If filters are changed, we drop this table.
CREATE TABLE RejectedFile (
  id INTEGER NOT NULL PRIMARY KEY,
  dirUriId INTEGER NOT NULL REFERENCES DirUri (id),
  basename TEXT NOT NULL, -- Just the filename portion of the URI
  mtime INTEGER NOT NULL,
  fileSize INTEGER NOT NULL,
  why TEXT NOT NULL,
  updatedAt INTEGER NOT NULL
) STRICT;

CREATE UNIQUE INDEX IF NOT EXISTS RejectedFile_udx ON RejectedFile (dirUriId, basename);

-- Cleanup trigger for the tag_fts table:
CREATE TRIGGER tag_ad AFTER DELETE ON Tag BEGIN
DELETE FROM tag_fts
WHERE
  rowid = OLD.id;

END;
