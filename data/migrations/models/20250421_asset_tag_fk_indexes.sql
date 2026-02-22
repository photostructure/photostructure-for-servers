-- Indexes on foreign keys are _ACTUALLY NEEDED_: see https://sqlite.org/foreignkeys.html
-- incorrect name:
DROP INDEX IF EXISTS assettag_fks;

-- We're going to make cover indexes, not just an index on assetId or tagId
-- specifically:
DROP INDEX IF EXISTS AssetTag_assetId_idx;

DROP INDEX IF EXISTS AssetTag_tagId_idx;

-- Cover indexes for AssetTag -- and yeah, we need both.
DROP INDEX IF EXISTS AssetTag_tagId_assetId_idx;

DROP INDEX IF EXISTS AssetTag_tagId_assetId_udx;

-- we're arbitrarily picking one of these indexes to enforce the unique constraint:
CREATE UNIQUE INDEX AssetTag_tagId_assetId_udx ON AssetTag (tagId, assetId);

DROP INDEX IF EXISTS AssetTag_assetId_tagId_idx;

CREATE INDEX AssetTag_assetId_tagId_idx ON AssetTag (assetId, tagId);
