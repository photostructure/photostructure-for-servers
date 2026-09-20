-- Keep a best-effort native directory path for psfile URI resolution.
ALTER TABLE DirUri
ADD COLUMN nativePath TEXT;
