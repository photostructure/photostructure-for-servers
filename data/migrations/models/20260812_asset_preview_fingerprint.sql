-- Preview provenance for the currently published preview set.
--
-- All of it lands in one structural migration, deliberately: the conversion
-- Operation that backfills these columns is version-gated by
-- Operation.applyOnce_, so a column added after that version is bumped would
-- never reach a library that already completed the conversion.
--
-- renderWidth/renderHeight are the ORIENTED dimensions of the pixels the render
-- source produces -- an embedded JPEG, a RAW raster, or a video frame -- not the
-- recorded AssetFile dimensions. The preview ladder derives from them, so the
-- browser needs them to address a rung.
--
-- previewSourceMtime/previewSourceSize are the two provenance inputs compared
-- with a tolerance (mtimeMsEpsilon / fileSizeEpsilon) rather than exactly, which
-- is why they get their own columns instead of living inside the fingerprint.
ALTER TABLE Asset
ADD COLUMN previewFingerprint TEXT;

ALTER TABLE Asset
ADD COLUMN renderWidth INTEGER;

ALTER TABLE Asset
ADD COLUMN renderHeight INTEGER;

ALTER TABLE Asset
ADD COLUMN previewSourceMtime INTEGER;

ALTER TABLE Asset
ADD COLUMN previewSourceSize INTEGER;
