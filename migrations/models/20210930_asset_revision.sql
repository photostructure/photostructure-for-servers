CREATE TABLE "AssetRevision" -- Any change made to an Asset through the PhotoStructure UI creates an "AssetRevision" which can then be merged with any external changes made to files or sidecars.
(
  id integer NOT NULL PRIMARY KEY,
  assetId integer NOT NULL,
  createdAt bigint NOT NULL,
  field varchar(255) NOT NULL,
  op varchar(8),
  -- For singular fields, op is null. 
  -- For additions to array fields (like keywords), op is "add", _priorValue is ignored, _newValue is the added keyword. 
  -- For deletions to array fields (like keywords), op is "delete", _priorValue is the value to delete, and _newValue is ignored.
  _priorValueJson varchar(255),
  _newValueJson varchar(255),
  FOREIGN KEY(assetId) REFERENCES Asset(id)
);