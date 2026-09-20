-- Cover the substring search on AssetFile.basename.
--
-- Both a bare search term ("napa") and an explicit name:/file:/fn: term match
-- filenames with `basename LIKE '%term%'`. No index can seek a leading
-- wildcard, but a covering index on (basename, assetId) answers the whole
-- subquery from the index instead of scanning the AssetFile table, which
-- carries every metadata column.
--
-- Measured on a 69k-asset library (180k AssetFile rows): AssetFile is 79 MB,
-- this index is 4.5 MB, and a bare-term search drops from ~48 ms to ~24 ms.
DROP INDEX IF EXISTS AssetFile_basename_idx;

CREATE INDEX AssetFile_basename_idx ON AssetFile (basename, assetId);
