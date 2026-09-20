-- Normalized projection of osxphotos tests/Test-10.12.6.photoslibrary/database/photos.db
-- Source commit b99f58636f83d0a4012217731d98fc98d4b7ed9f; attribution and transformations: docs/third-party-fixtures.md.
-- No media. Unused columns/tables omitted; original consumed values and identity indexes retained.
CREATE TABLE "LiGlobals" ("keyPath" varchar, "value" varchar);

INSERT INTO
  "LiGlobals"
VALUES
  ('libraryVersion', '2622');

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
    1,
    'lQ1jG4ORRwGaRf6PvZuxvw',
    0,
    NULL,
    460483,
    2048,
    1367,
    'wedding.jpg',
    '2019/08/24/20190824-030824/wedding.jpg',
    'wedding.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    2,
    'oSzFuNlXSXWqLtX+i41yfw',
    0,
    NULL,
    512561,
    2047,
    1365,
    'Tulips.jpg',
    '2019/08/24/20190824-030824/Tulips.jpg',
    'Tulips.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    3,
    '129zfn4LQlCN%tjdQrUnJQ',
    0,
    NULL,
    541174,
    1365,
    2048,
    'Pumkins2.jpg',
    '2019/08/24/20190824-030824/Pumkins2.jpg',
    'Pumkins2.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    4,
    'CcAz82PVQ5CdZNnGQiKOLQ',
    0,
    NULL,
    554127,
    2048,
    1365,
    'Pumkins1.jpg',
    '2019/08/24/20190824-030824/Pumkins1.jpg',
    'Pumkins1.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    5,
    'xcOXanPVSJebgFHBqh2lSg',
    0,
    NULL,
    588140,
    1365,
    2048,
    'Pumpkins3.jpg',
    '2019/08/24/20190824-030824/Pumpkins3.jpg',
    'Pumpkins3.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    6,
    'YqVYH5DKQBK%ht7Vbj1MPA',
    0,
    NULL,
    1262861,
    2047,
    1356,
    'St James Park.jpg',
    '2019/08/24/20190824-030824/St James Park.jpg',
    'St James Park.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    7,
    'WZ4xiQFvQkCQ3NOiwVycyg',
    1,
    NULL,
    1588123,
    2917,
    3000,
    'pumpkin4.jpg',
    'Users/Shared/pumpkin4.jpg',
    'pumpkin4.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    8,
    'dBljvPjGSjGd11MMEACsMQ',
    0,
    NULL,
    2901554,
    4416,
    3312,
    'IMG_1994.JPG',
    '2020/04/17/20200417-184043/IMG_1994.JPG',
    'IMG_1994.JPG'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    9,
    'Ffn0RSP+Tz24XPPXcZucrQ',
    0,
    NULL,
    16128420,
    4416,
    3312,
    'IMG_1994.CR2',
    '2020/04/17/20200417-184043/IMG_1994.CR2',
    'IMG_1994.CR2'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    10,
    'hA3cNKghS6GiLLCqBgS1JA',
    0,
    NULL,
    17610159,
    4416,
    3312,
    'IMG_1998.CR2',
    '2020/04/17/20200417-184207/IMG_1998.CR2',
    'IMG_1998.CR2'
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
    1,
    'DYy7J97KSTy62FcRprpDvg',
    NULL,
    0,
    0,
    0,
    577057224.086,
    -25200,
    'lQ1jG4ORRwGaRf6PvZuxvw',
    NULL,
    'lQ1jG4ORRwGaRf6PvZuxvw',
    'GMT-0700',
    NULL,
    NULL,
    NULL,
    1,
    'Bride wedding day',
    0.65625
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    2,
    'HWsxlzxlQ++1TUPg2XNUgg',
    'Tulips tied together at a flower shop',
    0,
    0,
    0,
    583975441,
    -25200,
    'oSzFuNlXSXWqLtX+i41yfw',
    NULL,
    'oSzFuNlXSXWqLtX+i41yfw',
    'GMT-0700',
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
    3,
    'sE5LlfekS8ykEE7o0cuMVA',
    'I found one!',
    0,
    0,
    0,
    559858027,
    -14400,
    '129zfn4LQlCN%tjdQrUnJQ',
    NULL,
    '129zfn4LQlCN%tjdQrUnJQ',
    'America/New_York',
    NULL,
    NULL,
    NULL,
    1,
    'Girl holding pumpkin',
    0.65625
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    4,
    'UFMoHg17SwaPSyz7li4y2Q',
    'Can we carry this?',
    0,
    0,
    0,
    559866949.063,
    -25200,
    'CcAz82PVQ5CdZNnGQiKOLQ',
    NULL,
    'CcAz82PVQ5CdZNnGQiKOLQ',
    'GMT-0700',
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
    5,
    '2TqWg%U5TiS6kNcG1MKzHA',
    NULL,
    0,
    0,
    0,
    559868973.022,
    -25200,
    'xcOXanPVSJebgFHBqh2lSg',
    NULL,
    'xcOXanPVSJebgFHBqh2lSg',
    'GMT-0700',
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
    6,
    'N6w0wuZRSEC3l2wyabbjRQ',
    'St. James''s Park',
    0,
    0,
    0,
    561140292.501,
    -25200,
    'YqVYH5DKQBK%ht7Vbj1MPA',
    NULL,
    'YqVYH5DKQBK%ht7Vbj1MPA',
    'GMT-0700',
    NULL,
    51.50357167,
    -0.1318055,
    1,
    NULL,
    0.5
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    7,
    'Pj99JmYjQkeezdY2OFuSaw',
    'Pumpkin heads',
    0,
    0,
    0,
    559867199.008,
    -25200,
    'WZ4xiQFvQkCQ3NOiwVycyg',
    NULL,
    'WZ4xiQFvQkCQ3NOiwVycyg',
    'GMT-0700',
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
    8,
    '+6wHHkUSTWWyz7TYEsbGtQ',
    NULL,
    0,
    0,
    0,
    608664351,
    -25200,
    'dBljvPjGSjGd11MMEACsMQ',
    'Ffn0RSP+Tz24XPPXcZucrQ',
    'dBljvPjGSjGd11MMEACsMQ',
    'GMT-0700',
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
    9,
    'FPm+ICxpQV+LPBKR22UepA',
    NULL,
    0,
    0,
    0,
    608757235,
    -25200,
    'hA3cNKghS6GiLLCqBgS1JA',
    'hA3cNKghS6GiLLCqBgS1JA',
    NULL,
    'GMT-0700',
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
    'VwOUaFMlSry5+51f6q8uyw',
    'Tulips tied together at a flower shop – Version 2',
    0,
    0,
    0,
    583975441,
    -25200,
    'oSzFuNlXSXWqLtX+i41yfw',
    NULL,
    'oSzFuNlXSXWqLtX+i41yfw',
    'GMT-0700',
    NULL,
    NULL,
    NULL,
    1,
    'Wedding tulips',
    0.5
  );

CREATE INDEX RKVersion_uuid_index on RKVersion (uuid);

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
  (14, 'Digital Nomad');

INSERT INTO
  "RKKeyword"
VALUES
  (26, 'England');

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
  (3, 'Kids');

INSERT INTO
  "RKKeyword"
VALUES
  (25, 'London');

INSERT INTO
  "RKKeyword"
VALUES
  (22, 'London 2018');

INSERT INTO
  "RKKeyword"
VALUES
  (12, 'Reiseblogger');

INSERT INTO
  "RKKeyword"
VALUES
  (23, 'St. James''s Park');

INSERT INTO
  "RKKeyword"
VALUES
  (20, 'Stock Photography');

INSERT INTO
  "RKKeyword"
VALUES
  (9, 'Top Shot');

INSERT INTO
  "RKKeyword"
VALUES
  (21, 'UK');

INSERT INTO
  "RKKeyword"
VALUES
  (24, 'United Kingdom');

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
  (19, 'design');

INSERT INTO
  "RKKeyword"
VALUES
  (7, 'display');

INSERT INTO
  "RKKeyword"
VALUES
  (27, 'f');

INSERT INTO
  "RKKeyword"
VALUES
  (16, 'fake');

INSERT INTO
  "RKKeyword"
VALUES
  (10, 'flower');

INSERT INTO
  "RKKeyword"
VALUES
  (28, 'flowers');

INSERT INTO
  "RKKeyword"
VALUES
  (17, 'outdoor');

INSERT INTO
  "RKKeyword"
VALUES
  (8, 'photography');

INSERT INTO
  "RKKeyword"
VALUES
  (18, 'plastic');

INSERT INTO
  "RKKeyword"
VALUES
  (5, 'stock photo');

INSERT INTO
  "RKKeyword"
VALUES
  (13, 'vibrant');

INSERT INTO
  "RKKeyword"
VALUES
  (29, 'wedding');

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
  (17, 6, 21);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (18, 6, 24);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (19, 6, 23);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (20, 6, 26);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (21, 6, 22);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (22, 6, 25);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (24, 2, 28);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (25, 2, 29);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (26, 4, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (27, 1, 29);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (28, 3, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (29, 5, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (30, 7, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (31, 10, 28);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (32, 10, 29);

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
  (3, 1, 2, 'All Photos', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (4, 1, 3, 'Last Import', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (5, 1, 2, 'Favorites', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (6, 1, 2, 'Hidden', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (7, 1, 2, 'Bursts', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (8, 1, 2, 'Panoramas', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (9, 1, 2, 'Screenshots', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (10, 1, 2, 'Videos', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (11, 1, 2, 'Slo-mo', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (12, 1, 2, 'Time-lapse', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (13, 1, 2, 'My Photo Stream', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (14, 1, 2, 'Selfies', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (15, 1, 2, 'People', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (16, 1, 2, 'Places', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (17, 1, 2, 'Favorite Memories', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (18, 1, 2, 'Depth Effect', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (19, 1, 2, 'Live Photos', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (20, 1, 3, 'Pumpkin Farm', 'TopLevelAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (21, 1, 1, NULL, '0WTtS2IfSKGT47OU%2ULuA', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (22, 1, 1, NULL, 'QCMyQ7EVQ0+jGgkZ0kV6mA', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    23,
    1,
    3,
    'AlbumInFolder',
    'QCMyQ7EVQ0+jGgkZ0kV6mA',
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
  (7, 3, 20);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (8, 4, 20);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (9, 5, 20);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (12, 9, 4);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (13, 3, 23);

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
  (8, 'Suzy');

INSERT INTO
  "RKPerson"
VALUES
  (9, 'Katie');

INSERT INTO
  "RKPerson"
VALUES
  (10, 'Katie');

INSERT INTO
  "RKPerson"
VALUES
  (11, 'Suzy');

INSERT INTO
  "RKPerson"
VALUES
  (12, 'Katie');

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
  (1, 0, 11, 5);

INSERT INTO
  "RKFace"
VALUES
  (2, 0, 12, 5);

INSERT INTO
  "RKFace"
VALUES
  (3, 0, 5, 5);

INSERT INTO
  "RKFace"
VALUES
  (4, 0, 8, 4);

INSERT INTO
  "RKFace"
VALUES
  (5, 0, 10, 3);

INSERT INTO
  "RKFace"
VALUES
  (6, 0, 7, 1);

INSERT INTO
  "RKFace"
VALUES
  (7, 0, 9, 4);

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
  (1, 1, 'United Kingdom', 'GB', 414681432064);

INSERT INTO
  "RKPlace"
VALUES
  (2, 2, 'England', NULL, 180406091776);

INSERT INTO
  "RKPlace"
VALUES
  (3, 4, 'London', NULL, 1596146816);

INSERT INTO
  "RKPlace"
VALUES
  (4, 16, 'Westminster', NULL, 22097376);

INSERT INTO
  "RKPlace"
VALUES
  (5, 45, 'St James''s Park', NULL, 263706.4375);

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
  (1, 6, 3);

INSERT INTO
  "RKPlaceForVersion"
VALUES
  (2, 6, 2);

INSERT INTO
  "RKPlaceForVersion"
VALUES
  (3, 6, 5);

INSERT INTO
  "RKPlaceForVersion"
VALUES
  (4, 6, 1);

INSERT INTO
  "RKPlaceForVersion"
VALUES
  (5, 6, 4);

CREATE INDEX RKPlaceForVersion_versionId_index on RKPlaceForVersion (versionId);

CREATE INDEX RKPlaceForVersion_placeId_index on RKPlaceForVersion (placeId);
