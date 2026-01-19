-- convert captured-at from millis-since-1970 to local-decisecond format:
ALTER TABLE Asset
ADD COLUMN capturedAtLocal INTEGER NULL;

WITH
  CTE AS (
    SELECT
      assetId,
      first_value(capturedAtLocal) OVER win AS cal
    FROM
      AssetFile
    WINDOW
      win AS (
        PARTITION BY
          assetId
        ORDER BY
          shown DESC
      )
  )
UPDATE Asset
SET
  capturedAtLocal = (
    SELECT
      CTE.cal
    FROM
      CTE
    WHERE
      CTE.assetId = Asset.id
  );

UPDATE Asset
SET
  shown = 0,
  capturedAtLocal = -1
WHERE
  capturedAtLocal IS NULL;

DROP TABLE IF EXISTS new_Asset;

CREATE TABLE new_Asset (
  id INTEGER NOT NULL PRIMARY KEY,
  capturedAtLocal INTEGER NOT NULL,
  shown INTEGER NOT NULL DEFAULT 0,
  hidden INTEGER NOT NULL DEFAULT 0,
  favorite INTEGER DEFAULT 0,
  version INTEGER NOT NULL DEFAULT 0,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL
);

INSERT INTO
  new_Asset
SELECT
  id,
  capturedAtLocal,
  shown,
  hidden,
  0 AS favorite,
  0 AS version,
  createdAt,
  updatedAt
FROM
  Asset;

DROP INDEX IF EXISTS asset_favorite_idx;

DROP INDEX IF EXISTS asset_favorite_idx;

DROP INDEX IF EXISTS asset_timeline;

DROP INDEX IF EXISTS asset_id_ver_idx;

DROP TABLE Asset;

ALTER TABLE new_Asset
RENAME TO Asset;

CREATE INDEX asset_cap_idx ON Asset (capturedAtLocal)
WHERE
  shown = 1
  AND hidden = 0;
