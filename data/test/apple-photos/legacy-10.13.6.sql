-- Normalized projection of osxphotos tests/Test-10.13.6.photoslibrary/database/photos.db
-- Source commit b99f58636f83d0a4012217731d98fc98d4b7ed9f; attribution and transformations: docs/third-party-fixtures.md.
-- No media. Unused columns/tables omitted; original consumed values and identity indexes retained.
CREATE TABLE "LiGlobals" ("keyPath" varchar, "value" varchar);

INSERT INTO
  "LiGlobals"
VALUES
  ('libraryVersion', '3301');

CREATE INDEX LiGlobals_keyPath_index on LiGlobals (keyPath);

CREATE TABLE "RKMaster" (
  "modelId" INTEGER,
  "uuid" varchar,
  "fileIsReference" INTEGER,
  "duration" decimal,
  "fileSize" INTEGER,
  "width" INTEGER,
  "height" INTEGER,
  "fileName" varchar,
  "imagePath" varchar,
  "originalFileName" varchar,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKMaster"
VALUES
  (
    2,
    'kIeFAtcVQcemrLkzNX1mUA',
    0,
    NULL,
    460483,
    2048,
    1367,
    'wedding.jpg',
    '2019/07/26/20190726-203227/wedding.jpg',
    'wedding.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    3,
    's87w%%dsS2eL8XHtHXdL8Q',
    0,
    NULL,
    588140,
    1365,
    2048,
    'Pumpkins3.jpg',
    '2019/07/26/20190726-203227/Pumpkins3.jpg',
    'Pumpkins3.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    4,
    'ntsSLVZ4Ttef+SKLwrYLyg',
    0,
    NULL,
    541174,
    1365,
    2048,
    'Pumkins2.jpg',
    '2019/07/26/20190726-203227/Pumkins2.jpg',
    'Pumkins2.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    5,
    'OpSr1N5%Snea3DmHjz5x4Q',
    0,
    NULL,
    554127,
    2048,
    1365,
    'Pumkins1.jpg',
    '2019/07/26/20190726-203227/Pumkins1.jpg',
    'Pumkins1.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    6,
    'mRaOXmW2Q4+INeclW7U7QQ',
    0,
    NULL,
    512561,
    2047,
    1365,
    'Tulips.jpg',
    '2019/07/26/20190726-203227/Tulips.jpg',
    'Tulips.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    9,
    '%uHM+VY7QDew1AY2yEPrng',
    1,
    NULL,
    700340,
    1991,
    2048,
    'Pumpkin4.jpg',
    'Users/Shared/Pumpkin4.jpg',
    'Pumpkin4.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    10,
    'TCk+uK5QQuePLsvX7NZvMw',
    0,
    NULL,
    1262861,
    2047,
    1356,
    'St James Park.jpg',
    '2019/07/28/20190728-013355/St James Park.jpg',
    'St James Park.jpg'
  );

CREATE INDEX RKMaster_uuid_index on RKMaster (uuid);

CREATE INDEX RKMaster_fileSize_index on RKMaster (fileSize);

CREATE INDEX RKMaster_fileName_index on RKMaster (fileName);

CREATE TABLE "RKVersion" (
  "modelId" INTEGER,
  "uuid" varchar,
  "name" varchar,
  "isFavorite" INTEGER,
  "isInTrash" INTEGER,
  "isHidden" INTEGER,
  "imageDate" timestamp,
  "imageTimeZoneOffsetSeconds" INTEGER,
  "masterUuid" varchar,
  "rawMasterUuid" varchar,
  "nonRawMasterUuid" varchar,
  "imageTimeZoneName" varchar,
  "overridePlaceId" INTEGER,
  "latitude" decimal,
  "longitude" decimal,
  "showInLibrary" INTEGER,
  "extendedDescription" varchar,
  "curationScore" decimal,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKVersion"
VALUES
  (
    2,
    'bVsCByeKSPGTLH7+h0cYOw',
    'Wedding day',
    0,
    0,
    0,
    577046424.086,
    -14400,
    'kIeFAtcVQcemrLkzNX1mUA',
    NULL,
    'kIeFAtcVQcemrLkzNX1mUA',
    'GMT-0400',
    NULL,
    NULL,
    NULL,
    1,
    'Bride',
    0.6625
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    3,
    'NlY8CklESxGpaKsTVHB3HQ',
    '',
    0,
    0,
    0,
    559858173.022,
    -14400,
    's87w%%dsS2eL8XHtHXdL8Q',
    NULL,
    's87w%%dsS2eL8XHtHXdL8Q',
    'GMT-0400',
    NULL,
    NULL,
    NULL,
    1,
    'Kids in pumpkin field',
    0.6875
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    4,
    'RWmFYiDjSyKjeK8Pfna0Eg',
    'I found one!',
    0,
    0,
    0,
    559858027,
    -14400,
    'ntsSLVZ4Ttef+SKLwrYLyg',
    NULL,
    'ntsSLVZ4Ttef+SKLwrYLyg',
    'GMT-0400',
    NULL,
    NULL,
    NULL,
    1,
    'Girl holding pumpkin',
    0.6625
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    5,
    'vAZGdUK1QdGfWPgC+KsJag',
    'Can we carry this?',
    0,
    0,
    0,
    559856149.063,
    -14400,
    'OpSr1N5%Snea3DmHjz5x4Q',
    NULL,
    'OpSr1N5%Snea3DmHjz5x4Q',
    'GMT-0400',
    NULL,
    NULL,
    NULL,
    1,
    'Girls with pumpkins',
    0.6875
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    6,
    'kmYe6VoLT36uiP2WATqTjA',
    'Tulips tied together at a flower shop',
    0,
    0,
    0,
    583964641,
    -14400,
    'mRaOXmW2Q4+INeclW7U7QQ',
    NULL,
    'mRaOXmW2Q4+INeclW7U7QQ',
    'GMT-0400',
    NULL,
    NULL,
    NULL,
    1,
    'Wedding tulips',
    0.5
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    9,
    '6iAZJP7ZQ5iXxapoJb3ytA',
    'Pumpkin heads',
    0,
    0,
    0,
    559856399.008,
    -14400,
    '%uHM+VY7QDew1AY2yEPrng',
    NULL,
    '%uHM+VY7QDew1AY2yEPrng',
    'GMT-0400',
    NULL,
    NULL,
    NULL,
    1,
    NULL,
    0.5
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    10,
    'XUGElxBPRyq6d+Cu7LFmwA',
    'St. James''s Park',
    0,
    0,
    0,
    561129492.501,
    -14400,
    'TCk+uK5QQuePLsvX7NZvMw',
    NULL,
    'TCk+uK5QQuePLsvX7NZvMw',
    'GMT-0400',
    NULL,
    51.50357167,
    -0.1318055,
    1,
    NULL,
    0.5
  );

CREATE INDEX RKVersion_uuid_index on RKVersion (uuid);

CREATE INDEX RKVersion_imageDate_index on RKVersion (imageDate);

CREATE INDEX RKVersion_masterUuid_index on RKVersion (masterUuid);

CREATE INDEX RKVersion_rawMasterUuid_index on RKVersion (rawMasterUuid);

CREATE INDEX RKVersion_nonRawMasterUuid_index on RKVersion (nonRawMasterUuid);

CREATE INDEX RKVersion_latitude_index on RKVersion (latitude);

CREATE INDEX RKVersion_longitude_index on RKVersion (longitude);

CREATE TABLE "RKKeyword" (
  "modelId" INTEGER,
  "name" varchar,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKKeyword"
VALUES
  (1, 'Birthday');

INSERT INTO
  "RKKeyword"
VALUES
  (18, 'Casas_USA');

INSERT INTO
  "RKKeyword"
VALUES
  (16, 'Digital Nomad');

INSERT INTO
  "RKKeyword"
VALUES
  (27, 'England');

INSERT INTO
  "RKKeyword"
VALUES
  (2, 'Family');

INSERT INTO
  "RKKeyword"
VALUES
  (15, 'Indoor');

INSERT INTO
  "RKKeyword"
VALUES
  (14, 'Juan_2019');

INSERT INTO
  "RKKeyword"
VALUES
  (3, 'Kids');

INSERT INTO
  "RKKeyword"
VALUES
  (31, 'London');

INSERT INTO
  "RKKeyword"
VALUES
  (28, 'London 2018');

INSERT INTO
  "RKKeyword"
VALUES
  (12, 'Reiseblogger');

INSERT INTO
  "RKKeyword"
VALUES
  (29, 'St. James''s Park');

INSERT INTO
  "RKKeyword"
VALUES
  (5, 'Stock Photography');

INSERT INTO
  "RKKeyword"
VALUES
  (9, 'Top Shot');

INSERT INTO
  "RKKeyword"
VALUES
  (32, 'UK');

INSERT INTO
  "RKKeyword"
VALUES
  (30, 'United Kingdom');

INSERT INTO
  "RKKeyword"
VALUES
  (4, 'Vacation');

INSERT INTO
  "RKKeyword"
VALUES
  (11, 'close up');

INSERT INTO
  "RKKeyword"
VALUES
  (6, 'colorful');

INSERT INTO
  "RKKeyword"
VALUES
  (22, 'design');

INSERT INTO
  "RKKeyword"
VALUES
  (7, 'display');

INSERT INTO
  "RKKeyword"
VALUES
  (17, 'fake');

INSERT INTO
  "RKKeyword"
VALUES
  (10, 'flower');

INSERT INTO
  "RKKeyword"
VALUES
  (26, 'flowers');

INSERT INTO
  "RKKeyword"
VALUES
  (23, 'house');

INSERT INTO
  "RKKeyword"
VALUES
  (19, 'outdoor');

INSERT INTO
  "RKKeyword"
VALUES
  (8, 'photography');

INSERT INTO
  "RKKeyword"
VALUES
  (20, 'plastic');

INSERT INTO
  "RKKeyword"
VALUES
  (21, 'stock photo');

INSERT INTO
  "RKKeyword"
VALUES
  (13, 'vibrant');

INSERT INTO
  "RKKeyword"
VALUES
  (25, 'we');

INSERT INTO
  "RKKeyword"
VALUES
  (24, 'wedding');

CREATE INDEX RKKeyword_name_index on RKKeyword (name);

CREATE TABLE "RKKeywordForVersion" (
  "modelId" INTEGER,
  "versionId" INTEGER,
  "keywordId" INTEGER,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (19, 3, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (20, 4, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (21, 5, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (24, 2, 24);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (26, 6, 24);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (27, 6, 26);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (34, 9, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (35, 10, 27);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (36, 10, 31);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (37, 10, 28);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (38, 10, 29);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (39, 10, 32);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (40, 10, 30);

CREATE INDEX RKKeywordForVersion_versionId_index on RKKeywordForVersion (versionId);

CREATE TABLE "RKAlbum" (
  "modelId" INTEGER,
  "albumType" INTEGER,
  "albumSubclass" INTEGER,
  "name" varchar,
  "folderUuid" varchar,
  "isInTrash" INTEGER,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKAlbum"
VALUES
  (1, 1, 1, NULL, 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (2, 1, 2, 'Trash', 'TrashFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (3, 1, 2, 'Imports', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (4, 1, 2, 'Favorites', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (5, 1, 2, 'Hidden', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (6, 1, 2, 'Bursts', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (7, 1, 2, 'Panoramas', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    8,
    1,
    2,
    'Screenshots',
    'MediaTypesSmartAlbums',
    0
  );

INSERT INTO
  "RKAlbum"
VALUES
  (9, 1, 2, 'Videos', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (10, 1, 2, 'Slo-mo', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    11,
    1,
    2,
    'Time-lapse',
    'MediaTypesSmartAlbums',
    0
  );

INSERT INTO
  "RKAlbum"
VALUES
  (12, 1, 2, 'My Photo Stream', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (13, 1, 2, 'Selfies', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (14, 1, 2, 'People', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (15, 1, 2, 'Places', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (16, 1, 2, 'Favorite Memories', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    17,
    1,
    2,
    'Depth Effect',
    'MediaTypesSmartAlbums',
    0
  );

INSERT INTO
  "RKAlbum"
VALUES
  (
    18,
    1,
    2,
    'Live Photos',
    'MediaTypesSmartAlbums',
    0
  );

INSERT INTO
  "RKAlbum"
VALUES
  (
    19,
    1,
    2,
    'Long Exposure',
    'MediaTypesSmartAlbums',
    0
  );

INSERT INTO
  "RKAlbum"
VALUES
  (20, 1, 2, 'Animated', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (21, 1, 2, 'Unable to Upload', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (22, 1, 2, 'All Photos', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (23, 1, 3, 'printAlbum', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (24, 1, 3, 'Pumpkin Farm', 'TopLevelAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (25, 1, 1, NULL, 'TopLevelAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (26, 1, 1, NULL, 'cHwwVoUiQ8a2nZNXgVsnCA', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    27,
    1,
    3,
    'AlbumInFolder',
    'MBS8+gBrQCWQxmcav+C8HQ',
    0
  );

INSERT INTO
  "RKAlbum"
VALUES
  (28, 1, 1, NULL, '%P+ZR1u3SDmngk2TSN50+g', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (29, 1, 1, NULL, 'MBS8+gBrQCWQxmcav+C8HQ', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    30,
    1,
    3,
    'TestAlbum',
    'obfeGcvoT1auxoh2Tu86OQ',
    0
  );

CREATE INDEX RKAlbum_folderUuid_index on RKAlbum (folderUuid);

CREATE TABLE "RKAlbumVersion" (
  "modelId" INTEGER,
  "versionId" INTEGER,
  "albumId" INTEGER,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (2, 3, 24);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (3, 4, 24);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (4, 5, 24);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (5, 4, 27);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (6, 3, 30);

CREATE INDEX RKAlbumVersion_versionId_index on RKAlbumVersion (versionId);

CREATE TABLE "RKPerson" (
  "modelId" INTEGER,
  "name" varchar,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKPerson"
VALUES
  (1, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (2, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (3, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (4, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (5, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (6, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (7, 'Maria');

INSERT INTO
  "RKPerson"
VALUES
  (8, 'Katie');

INSERT INTO
  "RKPerson"
VALUES
  (9, 'Suzy');

INSERT INTO
  "RKPerson"
VALUES
  (10, 'Katie');

INSERT INTO
  "RKPerson"
VALUES
  (11, 'Katie');

INSERT INTO
  "RKPerson"
VALUES
  (12, 'Suzy');

CREATE TABLE "RKFace" (
  "modelId" INTEGER,
  "isInTrash" INTEGER,
  "personId" INTEGER,
  "imageModelId" INTEGER,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKFace"
VALUES
  (1, 0, 10, 4);

INSERT INTO
  "RKFace"
VALUES
  (2, 0, 9, 5);

INSERT INTO
  "RKFace"
VALUES
  (3, 0, 12, 3);

INSERT INTO
  "RKFace"
VALUES
  (4, 0, 11, 3);

INSERT INTO
  "RKFace"
VALUES
  (5, 0, 6, 3);

INSERT INTO
  "RKFace"
VALUES
  (6, 0, 7, 2);

INSERT INTO
  "RKFace"
VALUES
  (7, 0, 8, 5);

CREATE INDEX RKFace_personId_index on RKFace (personId);

CREATE INDEX RKFace_imageModelId_index on RKFace (imageModelId);

CREATE TABLE "RKPlace" (
  "modelId" INTEGER,
  "type" INTEGER,
  "defaultName" varchar,
  "countryCode" varchar,
  "area" decimal,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKPlace"
VALUES
  (1, 1, 'United States', 'US', 10316422316032);

INSERT INTO
  "RKPlace"
VALUES
  (2, 2, 'California', NULL, 424739504128);

INSERT INTO
  "RKPlace"
VALUES
  (3, 4, 'Humboldt', NULL, 10505958400);

INSERT INTO
  "RKPlace"
VALUES
  (4, 16, 'Eureka', NULL, 16884130);

INSERT INTO
  "RKPlace"
VALUES
  (5, 1, 'United Kingdom', 'GB', 414681432064);

INSERT INTO
  "RKPlace"
VALUES
  (6, 2, 'England', NULL, 180406091776);

INSERT INTO
  "RKPlace"
VALUES
  (7, 4, 'London', NULL, 1596146816);

INSERT INTO
  "RKPlace"
VALUES
  (8, 16, 'Westminster', NULL, 22097376);

INSERT INTO
  "RKPlace"
VALUES
  (9, 45, 'St James''s Park', NULL, 263706.4375);

CREATE INDEX RKPlace_type_index on RKPlace (type);

CREATE TABLE "RKPlaceForVersion" (
  "modelId" INTEGER,
  "versionId" INTEGER,
  "placeId" INTEGER,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKPlaceForVersion"
VALUES
  (10, 10, 7);

INSERT INTO
  "RKPlaceForVersion"
VALUES
  (11, 10, 6);

INSERT INTO
  "RKPlaceForVersion"
VALUES
  (12, 10, 9);

INSERT INTO
  "RKPlaceForVersion"
VALUES
  (13, 10, 5);

INSERT INTO
  "RKPlaceForVersion"
VALUES
  (14, 10, 8);

CREATE INDEX RKPlaceForVersion_versionId_index on RKPlaceForVersion (versionId);

CREATE INDEX RKPlaceForVersion_placeId_index on RKPlaceForVersion (placeId);
