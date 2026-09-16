-- Normalized projection of osxphotos tests/Test-10.14.6.photoslibrary/database/photos.db
-- Source commit b99f58636f83d0a4012217731d98fc98d4b7ed9f; attribution and transformations: docs/third-party-fixtures.md.
-- No media. Unused columns/tables omitted; original consumed values and identity indexes retained.
CREATE TABLE "LiGlobals" ("keyPath" varchar, "value" varchar);

INSERT INTO
  "LiGlobals"
VALUES
  ('libraryVersion', '4025');

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
    '4GwqadagQJ2Ga7extqvFpw',
    0,
    NULL,
    460483,
    2048,
    1367,
    'wedding.jpg',
    '2019/07/27/20190727-131650/wedding.jpg',
    'wedding.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    2,
    '7OrdAeHSS5GEaACd8O4iYw',
    0,
    NULL,
    588140,
    1365,
    2048,
    'Pumpkins3.jpg',
    '2019/07/27/20190727-131650/Pumpkins3.jpg',
    'Pumpkins3.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    3,
    'XCUd1N3AQG2S7P6t+mMBeg',
    0,
    NULL,
    541174,
    1365,
    2048,
    'Pumkins2.jpg',
    '2019/07/27/20190727-131650/Pumkins2.jpg',
    'Pumkins2.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    4,
    '1LH+3uOySDqRMrjKHV5B9A',
    0,
    NULL,
    554127,
    2048,
    1365,
    'Pumkins1.jpg',
    '2019/07/27/20190727-131650/Pumkins1.jpg',
    'Pumkins1.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    5,
    'ZGhpHEoWSuKv20aW0htPJA',
    0,
    NULL,
    512561,
    2047,
    1365,
    'Tulips.jpg',
    '2019/07/27/20190727-131650/Tulips.jpg',
    'Tulips.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    6,
    'gy92f%kfTget37ojCEKG1g',
    0,
    NULL,
    1262861,
    2047,
    1356,
    'St James Park.jpg',
    '2019/07/27/20190727-131650/St James Park.jpg',
    'St James Park.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    7,
    'irwAaxgVT%CK0KeLSff7gQ',
    1,
    NULL,
    700340,
    1991,
    2048,
    'Pumpkins4.jpg',
    'Users/Shared/Pumpkins4.jpg',
    'Pumpkins4.jpg'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    9,
    'zVIELTMjS8eeuxMZwDXXUw',
    0,
    NULL,
    2991408,
    4416,
    3312,
    'IMG_1997.JPG',
    '2020/10/05/20201005-041506/IMG_1997.JPG',
    'IMG_1997.JPG'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    10,
    'naER3b75Q7OG065C8rs4sw',
    0,
    NULL,
    15921433,
    4416,
    3312,
    'IMG_1997.cr2',
    '2020/10/05/20201005-041506/IMG_1997.cr2',
    'IMG_1997.cr2'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    11,
    'GMnCPRNEQD6F9PiHYIf%8Q',
    0,
    NULL,
    2901554,
    4416,
    3312,
    'IMG_1994.JPG',
    '2020/10/05/20201005-041514/IMG_1994.JPG',
    'IMG_1994.JPG'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    12,
    'dQJJI6G8S2+MGtcNhm81FA',
    0,
    NULL,
    16128420,
    4416,
    3312,
    'IMG_1994.cr2',
    '2020/10/05/20201005-041514/IMG_1994.cr2',
    'IMG_1994.cr2'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    13,
    '5bl6rVzARniEfQgWt5Y%jA',
    0,
    NULL,
    48774438,
    4032,
    3024,
    'IMG_1693.tif',
    '2020/10/05/20201005-041520/IMG_1693.tif',
    'IMG_1693.tif'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    14,
    'aqTG6hn0SuW2v7hr6xaU1A',
    0,
    NULL,
    21473824,
    6000,
    4000,
    'DSC03584.dng',
    '2020/10/05/20201005-041542/DSC03584.dng',
    'DSC03584.dng'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    15,
    'h1yDuIXcS%+4otwYDo4zcw',
    0,
    NULL,
    1877314,
    3024,
    4032,
    'IMG_3092.heic',
    '2020/10/05/20201005-041653/IMG_3092.heic',
    'IMG_3092.heic'
  );

INSERT INTO
  "RKMaster"
VALUES
  (
    16,
    'g4CZZZR5Rbm9U7sP7HXw5A',
    0,
    NULL,
    2043452,
    2448,
    2448,
    'IMG_3984.jpeg',
    '2020/10/05/20201005-041858/IMG_3984.jpeg',
    'IMG_3984.jpeg'
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
    '6bxcNnzRQKGnK4uPrCJ9UQ',
    NULL,
    1,
    0,
    0,
    577046424.086,
    -14400,
    '4GwqadagQJ2Ga7extqvFpw',
    NULL,
    '4GwqadagQJ2Ga7extqvFpw',
    'GMT-0400',
    NULL,
    NULL,
    NULL,
    1,
    'Bride Wedding day',
    0.8975
  );

INSERT INTO
  "RKVersion"
VALUES
  (
    2,
    'HrK3ZQdlQ7qpDA0FgOYXLA',
    NULL,
    0,
    0,
    0,
    559858173.022,
    -14400,
    '7OrdAeHSS5GEaACd8O4iYw',
    NULL,
    '7OrdAeHSS5GEaACd8O4iYw',
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
    3,
    '15uNd7%8RguTEgNPKHfTWw',
    'I found one!',
    0,
    0,
    0,
    559858027,
    -14400,
    'XCUd1N3AQG2S7P6t+mMBeg',
    NULL,
    'XCUd1N3AQG2S7P6t+mMBeg',
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
    4,
    '8SOE9s0XQVGsuq4ONohTng',
    'Can we carry this?',
    0,
    0,
    0,
    559856149.063,
    -14400,
    '1LH+3uOySDqRMrjKHV5B9A',
    NULL,
    '1LH+3uOySDqRMrjKHV5B9A',
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
    5,
    'YZFCPY24TUySvpu7owiqxA',
    'Tulips tied together at a flower shop',
    0,
    0,
    0,
    123456789012345,
    -14400,
    'ZGhpHEoWSuKv20aW0htPJA',
    NULL,
    'ZGhpHEoWSuKv20aW0htPJA',
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
    6,
    '3Jn73XpSQQCluzRBMWRsMA',
    'St. James''s Park',
    0,
    0,
    0,
    561129492.501,
    -14400,
    'gy92f%kfTget37ojCEKG1g',
    NULL,
    'gy92f%kfTget37ojCEKG1g',
    'GMT-0400',
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
    'od0fmC7NQx+ayVr+%i06XA',
    'Pumpkin heads',
    0,
    0,
    1,
    559856399.008,
    -14400,
    'irwAaxgVT%CK0KeLSff7gQ',
    NULL,
    'irwAaxgVT%CK0KeLSff7gQ',
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
    9,
    'AcxIpfolT3KU2Ge84VG3yQ',
    NULL,
    0,
    0,
    0,
    608751778,
    -25200,
    'zVIELTMjS8eeuxMZwDXXUw',
    'naER3b75Q7OG065C8rs4sw',
    'zVIELTMjS8eeuxMZwDXXUw',
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
    'oTiMG6OfSP6d%nUTEOfvMg',
    NULL,
    0,
    0,
    0,
    608664351,
    -25200,
    'dQJJI6G8S2+MGtcNhm81FA',
    'dQJJI6G8S2+MGtcNhm81FA',
    'GMnCPRNEQD6F9PiHYIf%8Q',
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
    11,
    'URxYNAiXR9CTkXbUvWweAA',
    NULL,
    0,
    0,
    0,
    611027233,
    -25200,
    '5bl6rVzARniEfQgWt5Y%jA',
    NULL,
    '5bl6rVzARniEfQgWt5Y%jA',
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
    12,
    'DZAgPwQNTWiM+T5cX3WMqA',
    NULL,
    0,
    0,
    0,
    608405423,
    -25200,
    'aqTG6hn0SuW2v7hr6xaU1A',
    'aqTG6hn0SuW2v7hr6xaU1A',
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
    13,
    'GdJJPQX0RP63mcdKFj%sfQ',
    NULL,
    0,
    0,
    0,
    622244186.719,
    -25200,
    'h1yDuIXcS%+4otwYDo4zcw',
    NULL,
    'h1yDuIXcS%+4otwYDo4zcw',
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
    14,
    'td4yIljYS8aRAgzlsRRDtQ',
    NULL,
    0,
    1,
    0,
    480902708.15,
    -25200,
    'g4CZZZR5Rbm9U7sP7HXw5A',
    NULL,
    'g4CZZZR5Rbm9U7sP7HXw5A',
    'GMT-0700',
    NULL,
    NULL,
    NULL,
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
  (5, 'Digital Nomad');

INSERT INTO
  "RKKeyword"
VALUES
  (8, 'England');

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
  (19, 'London');

INSERT INTO
  "RKKeyword"
VALUES
  (26, 'London 2018');

INSERT INTO
  "RKKeyword"
VALUES
  (14, 'Reiseblogger');

INSERT INTO
  "RKKeyword"
VALUES
  (10, 'St. James''s Park');

INSERT INTO
  "RKKeyword"
VALUES
  (12, 'Stock Photography');

INSERT INTO
  "RKKeyword"
VALUES
  (6, 'Top Shot');

INSERT INTO
  "RKKeyword"
VALUES
  (21, 'UK');

INSERT INTO
  "RKKeyword"
VALUES
  (13, 'United Kingdom');

INSERT INTO
  "RKKeyword"
VALUES
  (4, 'Vacation');

INSERT INTO
  "RKKeyword"
VALUES
  (24, 'close up');

INSERT INTO
  "RKKeyword"
VALUES
  (9, 'colorful');

INSERT INTO
  "RKKeyword"
VALUES
  (18, 'design');

INSERT INTO
  "RKKeyword"
VALUES
  (23, 'display');

INSERT INTO
  "RKKeyword"
VALUES
  (16, 'fake');

INSERT INTO
  "RKKeyword"
VALUES
  (7, 'flower');

INSERT INTO
  "RKKeyword"
VALUES
  (30, 'flowers');

INSERT INTO
  "RKKeyword"
VALUES
  (29, 'kids');

INSERT INTO
  "RKKeyword"
VALUES
  (25, 'outdoor');

INSERT INTO
  "RKKeyword"
VALUES
  (17, 'photography');

INSERT INTO
  "RKKeyword"
VALUES
  (11, 'plastic');

INSERT INTO
  "RKKeyword"
VALUES
  (22, 'stock photo');

INSERT INTO
  "RKKeyword"
VALUES
  (20, 'vibrant');

INSERT INTO
  "RKKeyword"
VALUES
  (28, 'we');

INSERT INTO
  "RKKeyword"
VALUES
  (27, 'wedding');

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
  (17, 6, 8);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (18, 6, 19);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (19, 6, 26);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (20, 6, 10);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (21, 6, 21);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (22, 6, 13);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (23, 1, 27);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (25, 5, 27);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (29, 5, 30);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (30, 7, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (31, 3, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (32, 4, 3);

INSERT INTO
  "RKKeywordForVersion"
VALUES
  (33, 2, 3);

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
  (23, 1, 3, 'Pumpkin Farm', 'TopLevelAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (24, 1, 1, NULL, 'TopLevelAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (25, 1, 2, 'Trash', 'TrashFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (26, 1, 2, 'Imports', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (27, 1, 2, 'Favorites', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (28, 1, 2, 'Hidden', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (29, 1, 2, 'Bursts', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (30, 1, 2, 'Panoramas', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    31,
    1,
    2,
    'Screenshots',
    'MediaTypesSmartAlbums',
    0
  );

INSERT INTO
  "RKAlbum"
VALUES
  (32, 1, 2, 'Videos', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (33, 1, 2, 'Slo-mo', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    34,
    1,
    2,
    'Time-lapse',
    'MediaTypesSmartAlbums',
    0
  );

INSERT INTO
  "RKAlbum"
VALUES
  (35, 1, 2, 'My Photo Stream', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (36, 1, 2, 'Selfies', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (37, 1, 2, 'People', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (38, 1, 2, 'Places', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (39, 1, 2, 'Favorite Memories', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    40,
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
    41,
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
    42,
    1,
    2,
    'Long Exposure',
    'MediaTypesSmartAlbums',
    0
  );

INSERT INTO
  "RKAlbum"
VALUES
  (43, 1, 2, 'Animated', 'MediaTypesSmartAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (44, 1, 2, 'Unable to Upload', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (45, 1, 2, 'All Photos', 'LibraryFolder', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (46, 1, 3, 'Test Album', 'TopLevelAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (47, 1, 3, 'Test Album (1)', 'TopLevelAlbums', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (48, 1, 1, NULL, 'N7eQ4VhfTfeHFp9PPHaJDw', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (49, 1, 1, NULL, 'QtSnVvTkQ%i2z3hB834M1A', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (50, 1, 1, NULL, 'zKnaWgPUSsu%tDd0Yub7rg', 0);

INSERT INTO
  "RKAlbum"
VALUES
  (
    51,
    1,
    3,
    'AlbumInFolder',
    'QtSnVvTkQ%i2z3hB834M1A',
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
  (1, 2, 23);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (2, 3, 23);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (3, 4, 23);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (4, 4, 46);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (5, 3, 47);

INSERT INTO
  "RKAlbumVersion"
VALUES
  (6, 3, 51);

CREATE INDEX RKAlbumVersion_versionId_index on RKAlbumVersion (versionId);

CREATE TABLE "RKPerson" (
  "modelId" INTEGER,
  "name" varchar,
  PRIMARY KEY ("modelId")
);

INSERT INTO
  "RKPerson"
VALUES
  (1, 'Katie');

INSERT INTO
  "RKPerson"
VALUES
  (2, 'Suzy');

INSERT INTO
  "RKPerson"
VALUES
  (3, 'Katie');

INSERT INTO
  "RKPerson"
VALUES
  (4, 'Suzy');

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
  (7, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (8, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (9, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (10, NULL);

INSERT INTO
  "RKPerson"
VALUES
  (11, 'Maria');

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
  (1, 0, 1, 3);

INSERT INTO
  "RKFace"
VALUES
  (2, 0, 2, 2);

INSERT INTO
  "RKFace"
VALUES
  (3, 0, 1, 2);

INSERT INTO
  "RKFace"
VALUES
  (4, 0, 10, 2);

INSERT INTO
  "RKFace"
VALUES
  (5, 0, 2, 4);

INSERT INTO
  "RKFace"
VALUES
  (6, 0, 11, 1);

INSERT INTO
  "RKFace"
VALUES
  (7, 0, 1, 4);

INSERT INTO
  "RKFace"
VALUES
  (9, 0, 1, NULL);

INSERT INTO
  "RKFace"
VALUES
  (10, 0, 2, NULL);

INSERT INTO
  "RKFace"
VALUES
  (11, 0, 2, NULL);

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
  (5, 45, 'St James''s Park', NULL, 0);

INSERT INTO
  "RKPlace"
VALUES
  (6, 1, 'United States', 'US', 10316422316032);

INSERT INTO
  "RKPlace"
VALUES
  (7, 2, 'District of Columbia', NULL, 177237168);

INSERT INTO
  "RKPlace"
VALUES
  (8, 16, 'Washington', NULL, 3333750.5);

INSERT INTO
  "RKPlace"
VALUES
  (9, 43, 'Adams Morgan', NULL, 1025728.9375);

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
