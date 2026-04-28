-- Add nullable `label` column to Volume so we can render a friendly tag display
-- name (e.g. "Photos USB Drive") even when the volume is currently unmounted.
-- Populated by Volume.onVolumeGet() from VolumeMetadata.label.
ALTER TABLE Volume
ADD COLUMN label TEXT;
