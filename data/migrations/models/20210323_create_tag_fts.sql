-- See https://www.sqlite.org/fts5.html#external_content_tables
-- https://www.sqlite.org/fts5.html#tokenizers
-- These triggers require the `tag_fts_root` and `tag_fts_path`
-- functions to be installed.
DROP TABLE IF EXISTS tag_fts;

CREATE VIRTUAL TABLE tag_fts USING fts5 (root, path, content = '', tokenize = "unicode61");

-- we're not going to use triggers, because we want to support non-materialized
-- display paths at some point soon.
-- -- Triggers to keep the FTS index up to date.
-- CREATE TRIGGER tag_ai AFTER INSERT ON Tag BEGIN
--   INSERT INTO tag_path_fts(rowid, root, path) VALUES (new.id, tag_fts_root(new._path), tag_fts_path(new._path));
-- END;
-- CREATE TRIGGER tag_ad AFTER DELETE ON Tag BEGIN
--   INSERT INTO tag_path_fts(rowid, path) VALUES ('delete', tag_fts_root(old._path), tag_fts_path(old._path));
-- END;
-- CREATE TRIGGER tag_au AFTER UPDATE ON Tag BEGIN
--   INSERT INTO tag_path_fts(rowid, path) VALUES ('delete', tag_fts_root(old._path), tag_fts_path(old._path));
--   INSERT INTO tag_path_fts(rowid, root, path) VALUES (new.id, tag_fts_root(new._path), tag_fts_path(new._path));
-- END;
-- -- drive the trigger:
-- update tag set tag.updatedAt = tag.updatedAt + 1;
