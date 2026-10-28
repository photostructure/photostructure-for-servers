-- v2026.9.6 rejected readable files whose permissions its readability check
-- misjudged, and cached those rejections. v2026.10.0 fixed the check but
-- invalidated none of those cached rejections, so those files stayed
-- excluded. Clear every cached rejection so each rejected file is examined
-- again.
DELETE FROM RejectedFile;
