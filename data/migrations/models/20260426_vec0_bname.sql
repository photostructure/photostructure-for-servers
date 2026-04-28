-- Add shortest normalized basename metadata to AssetFileHash vec0 table.
--
-- Vec0 virtual tables do not support ALTER TABLE, so we must drop and recreate.
-- The AssetFileHashHealthCheck will detect the missing/empty table and rebuild
-- the index with bname populated from AssetFile.basename.
DROP TABLE IF EXISTS AssetFileHash;
