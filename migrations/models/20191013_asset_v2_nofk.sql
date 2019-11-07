ALTER TABLE Asset ADD COLUMN capturedAtLocal integer NULL
;

WITH CTE AS (
  SELECT 
    assetId, 
    first_value(capturedAtLocal) OVER win as cal
  FROM AssetFile
  WINDOW win AS (PARTITION BY assetId ORDER BY shown DESC)
)
UPDATE 
  Asset 
SET 
  capturedAtLocal = (SELECT CTE.cal FROM CTE WHERE CTE.assetId = Asset.id)
;

UPDATE
  Asset
SET
  shown = 0,
  capturedAtLocal = -1
WHERE
  capturedAtLocal IS NULL
;

CREATE TABLE new_Asset (
  id integer NOT NULL PRIMARY KEY,
  capturedAtLocal integer NOT NULL, 
  shown integer NOT NULL DEFAULT 0,
  hidden integer NOT NULL DEFAULT 0, 
  favorite integer DEFAULT 0,
  version integer NOT NULL DEFAULT 0,
  createdAt bigint NOT NULL, 
  updatedAt bigint NOT NULL
)
;

INSERT INTO
  new_Asset
SELECT
  id,
  capturedAtLocal,
  shown,
  hidden,
  0 as favorite,
  0 as version,
  createdAt,
  updatedAt
FROM
  Asset
;

DROP INDEX IF EXISTS asset_favorite_idx
;
DROP INDEX IF EXISTS asset_favorite_idx
;
DROP INDEX IF EXISTS asset_timeline
;
DROP INDEX IF EXISTS asset_id_ver_idx
;

DROP TABLE Asset
;
ALTER TABLE new_Asset RENAME TO Asset
;

CREATE INDEX asset_cap_idx ON Asset ( capturedAtLocal ) 
  WHERE shown = 1 AND hidden = 0
;
