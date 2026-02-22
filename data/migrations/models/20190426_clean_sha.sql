-- Prior SHA was SHA512, truncated at 224 bits. That resulted in padded SHAs
-- (like "GBepjrg639k9No52xgMbNrOAHdAkgU2NK4qW8A=="). Those SHA are already
-- non-standard, and we don't really need more than 160 bits to be unique.
-- If I truncate to 32 characters, I get 192 bits, which is still plenty, and
-- our largest index (on SHA) goes on a big diet.
DROP INDEX IF EXISTS assetfile_sha_idx;

-- 192 bits, base64 encoded, is (192 / Math.log2(64)) == 32:
UPDATE AssetFile
SET
  sha = substr(sha, 0, 32);

CREATE INDEX assetfile_sha_idx ON AssetFile (sha);
