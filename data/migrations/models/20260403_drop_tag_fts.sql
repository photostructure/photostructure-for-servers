-- Drop the tag_fts FTS5 virtual table and its cleanup trigger.
-- Tag search now uses LIKE queries on Tag._path directly.
DROP TABLE IF EXISTS tag_fts;

DROP TRIGGER IF EXISTS tag_ad;
