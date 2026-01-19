-- Add scan generation tracking for resumable directory sync
--
-- lastVisitedGeneration: Tracks which scan generation last visited this file.
-- Files where lastVisitedGeneration < current generation weren't visited in the
-- current scan and are potentially stale (deleted from disk).
--
-- scanGeneration is stored in ProgressMeta (not Progress table) to track the
-- current/last generation for each sync path.
--
-- This replaces the boolean "unvisited" flag approach which required:
-- 1. Bulk update to mark all files unvisited at scan start (expensive)
-- 2. Ambiguity when scan is interrupted (can't distinguish "not yet reached" from "stale")
--
-- With generation counters:
-- - No bulk update at scan start (just increment counter in ProgressMeta)
-- - Interrupted scans can resume: files with currentGeneration were visited this scan
-- - Files with priorGeneration weren't visited yet (may be stale or just not reached)
ALTER TABLE AssetFile
ADD COLUMN lastVisitedGeneration INTEGER;

-- Initialize existing files with generation 0
-- New scans will use generation 1+, so all existing files will be checked
UPDATE AssetFile
SET
  lastVisitedGeneration = 0
WHERE
  lastVisitedGeneration IS NULL;

-- Index for efficient stale file queries
-- Query pattern: WHERE lastVisitedGeneration < ? AND dirUriId IN (SELECT id FROM DirUri WHERE uri LIKE ?)
CREATE INDEX IF NOT EXISTS idx_assetfile_generation ON AssetFile (lastVisitedGeneration);
