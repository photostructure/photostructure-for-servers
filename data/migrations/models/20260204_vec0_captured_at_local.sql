-- Add capturedAtLocal and capturedAtFuzzy metadata columns to AssetFileHash vec0 table
--
-- Vec0 virtual tables do not support ALTER TABLE, so we must drop and recreate.
-- The table will be recreated by ensureAssetFileHashTable() with the new schema:
--   - capturedAtLocal INTEGER (for time-windowed KNN queries)
--   - capturedAtFuzzy INTEGER (1 = fuzzy/mtime/path, 0 = precise/EXIF)
--
-- The AssetFileHashHealthCheck will detect the missing/empty table and auto-rebuild
-- the index with the new columns populated from AssetFile data.
DROP TABLE IF EXISTS AssetFileHash;
