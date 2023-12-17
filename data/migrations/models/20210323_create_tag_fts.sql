-- See https://www.sqlite.org/fts5.html#external_content_tables
-- https://www.sqlite.org/fts5.html#tokenizers
DROP TABLE IF EXISTS tag_fts;

CREATE VIRTUAL TABLE tag_fts USING fts5 (root, path, content = '', tokenize = "unicode61");
