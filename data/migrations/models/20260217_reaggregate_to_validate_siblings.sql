-- Move deprecated "reaggregate" flag (bit 0) to "validateSiblings" (bit 2).
-- Assets marked for reaggregation before the upgrade need sibling validation
-- to complete the equivalent work under the new dissolve-based system.
UPDATE Asset
SET
  flags = (flags | 4) & ~ 1
WHERE
  (flags & 1) != 0;
