CREATE INDEX IF NOT EXISTS asset_captured_at_geohash_idx ON Asset (capturedAt, geoHash)
WHERE
  geoHash IS NOT NULL;
