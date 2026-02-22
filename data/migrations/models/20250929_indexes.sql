DROP INDEX IF EXISTS Asset_capturedAtLocal_idx;

CREATE INDEX Asset_capturedAtLocal_idx ON Asset (capturedAtLocal)
WHERE
  shown = 1
  AND hidden = 0
  AND excludedAt IS NULL
  AND deletedAt IS NULL;

DROP INDEX IF EXISTS Asset_reaggregate_idx;

CREATE INDEX Asset_reaggregate_idx ON Asset (id)
WHERE
  (flags & 1) != 0;

DROP INDEX IF EXISTS Asset_sort_idx;

CREATE INDEX Asset_sort_idx ON Asset (id)
WHERE
  (flags & 2) != 0;

DROP INDEX IF EXISTS Asset_tag_idx;

CREATE INDEX Asset_tag_idx ON Asset (id)
WHERE
  (flags & 4) != 0;

DROP INDEX IF EXISTS Asset_previews_idx;

CREATE INDEX Asset_previews_idx ON Asset (id)
WHERE
  (flags & 8) != 0;

DROP INDEX IF EXISTS Asset_not_hidden_idx;

CREATE INDEX Asset_not_hidden_idx ON Asset (id)
WHERE
  hidden = 0
  AND excludedAt IS NULL
  AND deletedAt IS NULL;

DROP INDEX IF EXISTS Asset_captured_at_idx;

CREATE INDEX Asset_captured_at_idx ON Asset (id, capturedAtLocal);

DROP INDEX IF EXISTS AssetFile_imageDataHash_idx;

CREATE INDEX AssetFile_imageDataHash_idx ON AssetFile (imageDataHash)
WHERE
  imageDataHash IS NOT NULL;

DROP INDEX IF EXISTS AssetFile_primary_udx;

CREATE UNIQUE INDEX AssetFile_primary_udx ON AssetFile (assetId, isPrimary)
WHERE
  assetId IS NOT NULL
  AND isPrimary = 1;

DROP INDEX IF EXISTS AssetFile_sha_idx;

CREATE INDEX AssetFile_sha_idx ON AssetFile (sha);

DROP INDEX IF EXISTS AssetFile_assetId_idx;

CREATE INDEX AssetFile_assetId_idx ON AssetFile (assetId, flags);

DROP INDEX IF EXISTS AssetFile_uri_udx;

CREATE UNIQUE INDEX AssetFile_uri_udx ON AssetFile (dirUriId, basename);

-- Ensure `_path LIKE ...` is performant
DROP INDEX IF EXISTS tag_path_udx;

DROP INDEX IF EXISTS Tag_path_udx;

CREATE UNIQUE INDEX Tag_path_udx ON Tag (_path COLLATE NOCASE);

DROP INDEX IF EXISTS Tag_parentId_idx;

CREATE INDEX Tag_parentId_idx ON Tag (parentId);
