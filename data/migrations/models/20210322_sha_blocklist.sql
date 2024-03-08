CREATE TABLE "ShaBlocklist" (
  -- Files with any of these SHAs are not to be imported.
  sha VARCHAR(64) NOT NULL PRIMARY KEY
);
