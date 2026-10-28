-- PhotoStructure no longer asks ExifTool for ImageDataHash, and nothing reads
-- the stored digests (20261022-remove-image-data-hashing.md). Without this,
-- rows from older libraries kept their digest, upsert() wrote it back, and
-- SQLite maintained the partial index on every such write.
--
-- DROP COLUMN fails while an index uses the column, so drop the index first.
-- DROP COLUMN rewrites every AssetFile row: measured on a copy of a
-- 121,556-file library (SQLite 3.46.1, NVMe), the index drop took 0.03s and
-- the column drop 0.98s.
DROP INDEX IF EXISTS AssetFile_imageDataHash_idx;

ALTER TABLE AssetFile
DROP COLUMN imageDataHash;
