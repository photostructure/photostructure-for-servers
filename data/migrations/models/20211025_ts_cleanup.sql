UPDATE asset
SET
  excludedat = NULL
WHERE
  excludedat < 1633392000000;

UPDATE asset
SET
  deletedAt = NULL
WHERE
  deletedat < 1633392000000;
