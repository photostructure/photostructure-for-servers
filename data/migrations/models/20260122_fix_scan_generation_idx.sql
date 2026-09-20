DROP INDEX IF EXISTS idx_assetfile_generation;

-- Index for efficient stale file queries
-- Query pattern: WHERE lastVisitedGeneration < ? AND dirUriId IN (SELECT id FROM DirUri WHERE uri LIKE ?)
CREATE INDEX IF NOT EXISTS AssetFile_dirUriId_generation_idx ON AssetFile (dirUriId, lastVisitedGeneration);
