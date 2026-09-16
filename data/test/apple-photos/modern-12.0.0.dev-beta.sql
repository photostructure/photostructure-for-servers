-- Normalized projection of osxphotos tests/Test-12.0.0.dev-beta.photoslibrary/database/Photos.sqlite
-- Source commit b99f58636f83d0a4012217731d98fc98d4b7ed9f; attribution and transformations: docs/third-party-fixtures.md.
-- No media. Unused columns/tables omitted; original consumed values and identity indexes retained.
CREATE TABLE "Z_METADATA" (
  "Z_VERSION" INTEGER,
  "Z_UUID" VARCHAR(255),
  "Z_PLIST" BLOB,
  PRIMARY KEY ("Z_VERSION")
);

INSERT INTO
  "Z_METADATA"
VALUES
  (
    1,
    'FE941CCE-3AF4-4243-907C-C2233C09008D',
    X'62706c6973743030d101025e504c4d6f64656c56657273696f6e113b1e080b1a000000000000010100000000000000030000000000000000000000000000001d'
  );

CREATE TABLE "ZASSET" (
  "Z_PK" INTEGER,
  "ZFAVORITE" INTEGER,
  "ZHIDDEN" INTEGER,
  "ZTRASHEDSTATE" INTEGER,
  "ZADDITIONALATTRIBUTES" INTEGER,
  "ZDATECREATED" TIMESTAMP,
  "ZDURATION" FLOAT,
  "ZLATITUDE" FLOAT,
  "ZLONGITUDE" FLOAT,
  "ZOVERALLAESTHETICSCORE" FLOAT,
  "ZDIRECTORY" VARCHAR,
  "ZFILENAME" VARCHAR,
  "ZUUID" VARCHAR,
  "ZLOCATIONDATA" BLOB,
  PRIMARY KEY ("Z_PK")
);

INSERT INTO
  "ZASSET"
VALUES
  (
    1,
    0,
    1,
    0,
    2,
    559856399.008,
    0.0,
    -180.0,
    -180.0,
    0.51171875,
    '/Volumes/MacBook Mojave/Users/Shared',
    'Pumpkins4.jpg',
    'A1DD1F98-2ECD-431F-9AC9-5AFEFE2D3A5C',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    2,
    0,
    0,
    0,
    4,
    559858173.022,
    0.0,
    -180.0,
    -180.0,
    0.64794921875,
    '1',
    '1EB2B765-0765-43BA-A90C-0D0580E6172C.jpeg',
    '1EB2B765-0765-43BA-A90C-0D0580E6172C',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    3,
    1,
    0,
    0,
    6,
    577046424.086,
    0.0,
    -180.0,
    -180.0,
    0.853515625,
    'E',
    'E9BC5C36-7CD1-40A1-A72B-8B8FAC227D51.jpeg',
    'E9BC5C36-7CD1-40A1-A72B-8B8FAC227D51',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    4,
    0,
    0,
    0,
    5,
    559856149.063,
    0.0,
    -180.0,
    -180.0,
    0.60888671875,
    'F',
    'F12384F6-CD17-4151-ACBA-AE0E3688539E.jpeg',
    'F12384F6-CD17-4151-ACBA-AE0E3688539E',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    5,
    0,
    0,
    0,
    1,
    559858027,
    0.0,
    41.256566,
    -95.940257,
    0.71630859375,
    'D',
    'D79B8D77-BFFC-460B-9312-034F2877D35B.jpeg',
    'D79B8D77-BFFC-460B-9312-034F2877D35B',
    X'fda19927d7a044407235b22b2dfc57c000000000000000000000000000000000000000000000f0bf000000000000f0bf000000000000f0bfba4a5f8aa3a0c241'
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    6,
    0,
    0,
    0,
    7,
    561129492.501,
    0.0,
    51.50357167,
    -0.1318055,
    0.56591796875,
    'D',
    'DC99FBDD-7A52-4100-A5BB-344131646C30.jpeg',
    'DC99FBDD-7A52-4100-A5BB-344131646C30',
    X'caeb560975c049402f6af7ab00dfc0bfcdcccccccccc044000000000000000000000000000000000000000000000000000000000000000000000000000000000'
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    7,
    0,
    0,
    0,
    3,
    583964641,
    0.0,
    -180.0,
    -180.0,
    0.853515625,
    '6',
    '6191423D-8DB8-4D4C-92BE-9BBBA308AAC4.jpeg',
    '6191423D-8DB8-4D4C-92BE-9BBBA308AAC4',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    8,
    0,
    0,
    0,
    8,
    519637736.518,
    0.0,
    -34.91889167000001,
    138.59686167,
    0.59619140625,
    '3',
    '3DD2C897-F19E-4CA6-8C22-B027D5A71907.jpeg',
    '3DD2C897-F19E-4CA6-8C22-B027D5A71907',
    X'c29b033e9e7541c05a1ca57d195361400000000000804e400000000000000000000000000000000000000000000000000000000000000000a69b84e80af9be41'
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    9,
    0,
    0,
    0,
    9,
    608405423,
    0.0,
    -180.0,
    -180.0,
    0.5390625,
    'D',
    'D05A5FE3-15FB-49A1-A15D-AB3DA6F8B068.dng',
    'D05A5FE3-15FB-49A1-A15D-AB3DA6F8B068',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    10,
    0,
    0,
    0,
    10,
    608664351,
    0.0,
    -180.0,
    -180.0,
    0.6953125,
    'A',
    'A92D9C26-3A50-4197-9388-CB5F7DB9FA91.jpeg',
    'A92D9C26-3A50-4197-9388-CB5F7DB9FA91',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    11,
    0,
    0,
    0,
    11,
    608751778,
    0.0,
    -180.0,
    -180.0,
    0.470703125,
    '4',
    '4D521201-92AC-43E5-8F7C-59BC41C37A96.jpeg',
    '4D521201-92AC-43E5-8F7C-59BC41C37A96',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    12,
    0,
    0,
    0,
    12,
    608758101,
    0.0,
    -180.0,
    -180.0,
    0.3291015625,
    '/Users/rhet/Downloads',
    'IMG_2000.JPG',
    '8E1D7BC9-9321-44F9-8CFB-4083F6B9232A',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    13,
    0,
    0,
    0,
    13,
    123456789012345,
    0.0,
    -180.0,
    -180.0,
    0.51904296875,
    '8',
    '8846E3E6-8AC8-4857-8448-E3D025784410.tiff',
    '8846E3E6-8AC8-4857-8448-E3D025784410',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    14,
    0,
    0,
    1,
    14,
    602554058.704,
    0.0,
    38.917404999999995,
    -77.04176383000001,
    0.5,
    '7',
    '71E3E212-00EB-430D-8A63-5E294B268554.jpeg',
    '71E3E212-00EB-430D-8A63-5E294B268554',
    X'eb17ec866d7543405e003342ac4253c0cdcccccccc8c444000000000004050400000000000000000463beabfd9236f400000000000000000000080611ff5c141'
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    15,
    0,
    0,
    1,
    15,
    577057224.86,
    0.0,
    -180.0,
    -180.0,
    0.5,
    '6',
    '6FD38366-3BF2-407D-81FE-7153EB6125B6.jpeg',
    '6FD38366-3BF2-407D-81FE-7153EB6125B6',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    16,
    0,
    0,
    0,
    16,
    622244186.719,
    0.0,
    41.256566,
    -95.940257,
    0.541015625,
    '7',
    '7783E8E6-9CAC-40F3-BE22-81FB7051C266.heic',
    '7783E8E6-9CAC-40F3-BE22-81FB7051C266',
    X'fda19927d7a044407235b22b2dfc57c000000000000000000000000000000000000000000000f0bf000000000000f0bf000000000000f0bf74794bf5a1a0c241'
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    18,
    0,
    0,
    0,
    17,
    599955193,
    2.8633333333333333,
    34.053345,
    -118.242349,
    0.5,
    '3',
    '35329C57-B963-48D6-BB75-6AFF9370CBBC.mov',
    '35329C57-B963-48D6-BB75-6AFF9370CBBC',
    X'db334b02d4064140f94d61a5828f5dc000000000000000000000000000000000000000000000f0bf000000000000f0bf000000000000f0bf6cb284d5a8bdc241'
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    19,
    0,
    0,
    0,
    19,
    628838512,
    2.949,
    34.053345,
    -118.242349,
    0.5,
    'D',
    'D1359D09-1373-4F3B-B0E3-1A4DE573E4A3.mp4',
    'D1359D09-1373-4F3B-B0E3-1A4DE573E4A3',
    X'db334b02d4064140f94d61a5828f5dc000000000000000000000000000000000000000000000f0bf000000000000f0bf000000000000f0bf38ba643eebc4c241'
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    20,
    0,
    0,
    0,
    20,
    630214421.7666838,
    0.0,
    -180.0,
    -180.0,
    0.5,
    'E',
    'E2078879-A29C-4D6F-BACB-E3BBE6C3EB91.jpeg',
    'E2078879-A29C-4D6F-BACB-E3BBE6C3EB91',
    NULL
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    21,
    0,
    0,
    0,
    21,
    570920316.791,
    0.0,
    45.45076667,
    7.01066388,
    0.5,
    '7',
    '7F74DD34-5920-4DA3-B284-479887A34F66.jpeg',
    '7F74DD34-5920-4DA3-B284-479887A34F66',
    X'6fe3e4b8b2b94640d564df78eb0a1c403333333333519e4000000000004050400000000000000000a544f91f8cc8724000000000000000007d3f65bec603c141'
  );

INSERT INTO
  "ZASSET"
VALUES
  (
    22,
    0,
    0,
    0,
    22,
    570920316.791,
    0.0,
    45.45076667,
    7.01066388,
    0.5,
    '5',
    '52083079-73D5-4921-AC1B-FE76F279133F.jpeg',
    '52083079-73D5-4921-AC1B-FE76F279133F',
    X'6fe3e4b8b2b94640d564df78eb0a1c403333333333519e4000000000004050400000000000000000a544f91f8cc8724000000000000000007d3f65bec603c141'
  );

CREATE INDEX ZASSET_ZADDITIONALATTRIBUTES_INDEX ON ZASSET (ZADDITIONALATTRIBUTES);

CREATE INDEX Z_Asset_dateCreated ON ZASSET (ZDATECREATED COLLATE BINARY ASC);

CREATE INDEX Z_Asset_favorite ON ZASSET (ZFAVORITE COLLATE BINARY ASC);

CREATE INDEX Z_Asset_uuid ON ZASSET (ZUUID COLLATE BINARY ASC);

CREATE INDEX Z_Asset_byDateCreatedIndex ON ZASSET (ZDATECREATED COLLATE BINARY ASC);

CREATE INDEX Z_Asset_byFavoriteIndex ON ZASSET (ZFAVORITE COLLATE BINARY ASC);

CREATE INDEX Z_Asset_byUuidIndex ON ZASSET (ZUUID COLLATE BINARY ASC);

CREATE INDEX Z_Asset_compoundIndex2 ON ZASSET (
  ZDIRECTORY COLLATE BINARY ASC,
  ZFILENAME COLLATE BINARY ASC
);

CREATE TABLE "ZADDITIONALASSETATTRIBUTES" (
  "Z_PK" INTEGER,
  "ZORIGINALFILESIZE" INTEGER,
  "ZORIGINALHEIGHT" INTEGER,
  "ZORIGINALWIDTH" INTEGER,
  "ZTIMEZONEOFFSET" INTEGER,
  "ZASSET" INTEGER,
  "ZASSETDESCRIPTION" INTEGER,
  "ZACCESSIBILITYDESCRIPTION" VARCHAR,
  "ZEXIFTIMESTAMPSTRING" VARCHAR,
  "ZORIGINALFILENAME" VARCHAR,
  "ZTIMEZONENAME" VARCHAR,
  "ZTITLE" VARCHAR,
  "ZDATECREATEDSOURCE" INTEGER,
  PRIMARY KEY ("Z_PK")
);

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    1,
    541174,
    2048,
    1365,
    -14400,
    5,
    5,
    'Girl holding pumpkin',
    NULL,
    'Pumkins2.jpg',
    'GMT-0400',
    'I found one!',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    2,
    700340,
    2048,
    1991,
    -14400,
    1,
    NULL,
    NULL,
    NULL,
    'Pumpkins4.jpg',
    'GMT-0400',
    'Pumpkin heads',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    3,
    512561,
    1365,
    2047,
    -14400,
    7,
    1,
    'Wedding tulips',
    NULL,
    'Tulips.jpg',
    'GMT-0400',
    'Tulips tied together at a flower shop',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    4,
    588140,
    2048,
    1365,
    -14400,
    2,
    3,
    'Kids in pumpkin field',
    NULL,
    'Pumpkins3.jpg',
    'GMT-0400',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    5,
    554127,
    1365,
    2048,
    -14400,
    4,
    2,
    'Girls with pumpkins',
    NULL,
    'Pumkins1.jpg',
    'GMT-0400',
    'Can we carry this?',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    6,
    460483,
    1367,
    2048,
    -14400,
    3,
    4,
    'Bride Wedding day',
    NULL,
    'wedding.jpg',
    'GMT-0400',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    7,
    1262861,
    1356,
    2047,
    -14400,
    6,
    NULL,
    NULL,
    NULL,
    'St James Park.jpg',
    'GMT-0400',
    'St. James''s Park',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    8,
    1477654,
    2754,
    2754,
    34200,
    8,
    6,
    '⁨Elder Park⁩, ⁨Adelaide⁩, ⁨Australia⁩',
    '2017:06:20 17:18:56',
    'IMG_4547.jpg',
    'Australia/Adelaide',
    'Elder Park',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    9,
    21473824,
    4000,
    6000,
    -25200,
    9,
    8,
    'RAW only',
    '2020:04:12 10:30:23',
    'DSC03584.dng',
    'America/Los_Angeles',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    10,
    2901554,
    3312,
    4416,
    -25200,
    10,
    7,
    'RAW + JPEG, JPEG Original',
    '2020:04:15 10:25:51',
    'IMG_1994.JPG',
    'America/Los_Angeles',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    11,
    2991408,
    3312,
    4416,
    -25200,
    11,
    9,
    'RAW + JPEG, RAW original',
    '2020:04:16 10:42:58',
    'IMG_1997.JPG',
    'America/Los_Angeles',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    12,
    3869191,
    3312,
    4416,
    -25200,
    12,
    10,
    'RAW + JPEG, Not copied to library',
    '2020:04:16 12:28:21',
    'IMG_2000.JPG',
    'America/Los_Angeles',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    13,
    48774438,
    3024,
    4032,
    -25200,
    13,
    11,
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, the rest of this sentence is over 255 characters!',
    '2020:05:12 18:47:13',
    'IMG_1693.tif',
    'America/Los_Angeles',
    '',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    14,
    2175827,
    3024,
    4032,
    -18000,
    14,
    NULL,
    NULL,
    '2020:02:04 19:07:38',
    'IMG_1064.jpeg',
    'America/New_York',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    15,
    536126,
    1325,
    1526,
    -25200,
    15,
    NULL,
    NULL,
    '2019:04:15 14:40:24',
    'wedding_edited.jpg',
    'America/Los_Angeles',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    16,
    1877314,
    4032,
    3024,
    -25200,
    16,
    NULL,
    NULL,
    '2020:09:19 14:36:26',
    'IMG_3092.heic',
    'GMT-0700',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    17,
    2549087,
    720,
    1280,
    -28800,
    18,
    12,
    'Jellyfish Video',
    '2020:01:05 14:13:13',
    'Jellyfish.MOV',
    'America/Los_Angeles',
    'Jellyfish',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    19,
    999497,
    720,
    1280,
    -28800,
    19,
    14,
    'Jellyfish Video',
    '2020:12:04 21:21:52',
    'Jellyfish1.mp4',
    'America/Los_Angeles',
    'Jellyfish1',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    20,
    563237,
    1486,
    1854,
    -28800,
    20,
    NULL,
    NULL,
    NULL,
    'screenshot-really-a-png.jpeg',
    'America/Los_Angeles',
    NULL,
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    21,
    2759800,
    3024,
    4032,
    3600,
    21,
    15,
    'Menu SAVEURS
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
Error exporting photo (A128BC7E-246C-448E-BB33-11DB56471294: IMG_0615.HEIC) as /Users/fgarzon/Desktop/out/osxphotos/2019/2019-02 Paris - Val/2019-02-03-215836.jpeg: 
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de',
    '2019:02:03 21:58:36',
    'winebottle.jpeg',
    'GMT+0100',
    'L''atelier d''Edmond',
    0
  );

INSERT INTO
  "ZADDITIONALASSETATTRIBUTES"
VALUES
  (
    22,
    2759800,
    3024,
    4032,
    3600,
    22,
    16,
    'Menu SAVEURS
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
Error exporting photo (A128BC7E-246C-448E-BB33-11DB56471294: IMG_0615.HEIC) as /Users/fgarzon/Desktop/out/osxphotos/2019/2019-02 Paris - Val/2019-02-03-215836.jpeg: 
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de',
    '2019:02:03 21:58:36',
    'winebottle.jpeg',
    'GMT+0100',
    'L''atelier d''Edmond',
    0
  );

CREATE INDEX ZADDITIONALASSETATTRIBUTES_ZASSET_INDEX ON ZADDITIONALASSETATTRIBUTES (ZASSET);

CREATE INDEX ZADDITIONALASSETATTRIBUTES_ZASSETDESCRIPTION_INDEX ON ZADDITIONALASSETATTRIBUTES (ZASSETDESCRIPTION);

CREATE INDEX Z_AdditionalAssetAttributes_originalFilesize ON ZADDITIONALASSETATTRIBUTES (ZORIGINALFILESIZE COLLATE BINARY ASC);

CREATE INDEX Z_AdditionalAssetAttributes_byOriginalFileSize ON ZADDITIONALASSETATTRIBUTES (ZORIGINALFILESIZE COLLATE BINARY ASC);

CREATE TABLE "ZASSETDESCRIPTION" (
  "Z_PK" INTEGER,
  "ZLONGDESCRIPTION" VARCHAR,
  PRIMARY KEY ("Z_PK")
);

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (1, 'Wedding tulips');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (2, 'Girls with pumpkins');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (3, 'Kids in pumpkin field');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (4, 'Bride Wedding day');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (5, 'Girl holding pumpkin');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (6, '⁨Elder Park⁩, ⁨Adelaide⁩, ⁨Australia⁩');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (7, 'RAW + JPEG, JPEG Original');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (8, 'RAW only');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (9, 'RAW + JPEG, RAW original');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (10, 'RAW + JPEG, Not copied to library');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (
    11,
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, the rest of this sentence is over 255 characters!'
  );

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (12, 'Jellyfish Video');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (14, 'Jellyfish Video');

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (
    15,
    'Menu SAVEURS
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
Error exporting photo (A128BC7E-246C-448E-BB33-11DB56471294: IMG_0615.HEIC) as /Users/fgarzon/Desktop/out/osxphotos/2019/2019-02 Paris - Val/2019-02-03-215836.jpeg: 
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de'
  );

INSERT INTO
  "ZASSETDESCRIPTION"
VALUES
  (
    16,
    'Menu SAVEURS
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
Error exporting photo (A128BC7E-246C-448E-BB33-11DB56471294: IMG_0615.HEIC) as /Users/fgarzon/Desktop/out/osxphotos/2019/2019-02 Paris - Val/2019-02-03-215836.jpeg: 
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de Timut.
 - Mignardises et chocolats.
 - Amuse-Bouche.
 - Truite de Savoie grillée à la flamme, betteraves acidulées et Séchuan.
 - Poitrine de pintade fermière rôtie au parfum de café grillé, sarrasin et salsifis.
 - Fromages au plateau, sélection de fromages frais et affinés de Savoie
 - céleri et oseille.
 - Avant dessert.
 - Effiloché d’agrumes, mousse de riz au lait, Chartreuse et baie de'
  );

CREATE TABLE "ZKEYWORD" (
  "Z_PK" INTEGER,
  "ZTITLE" VARCHAR,
  PRIMARY KEY ("Z_PK")
);

INSERT INTO
  "ZKEYWORD"
VALUES
  (2, 'Birthday');

INSERT INTO
  "ZKEYWORD"
VALUES
  (11, 'Digital Nomad');

INSERT INTO
  "ZKEYWORD"
VALUES
  (38, 'Drink');

INSERT INTO
  "ZKEYWORD"
VALUES
  (15, 'England');

INSERT INTO
  "ZKEYWORD"
VALUES
  (14, 'Family');

INSERT INTO
  "ZKEYWORD"
VALUES
  (19, 'Indoor');

INSERT INTO
  "ZKEYWORD"
VALUES
  (3, 'Kids');

INSERT INTO
  "ZKEYWORD"
VALUES
  (30, 'London');

INSERT INTO
  "ZKEYWORD"
VALUES
  (7, 'London 2018');

INSERT INTO
  "ZKEYWORD"
VALUES
  (34, 'Maria');

INSERT INTO
  "ZKEYWORD"
VALUES
  (16, 'Reiseblogger');

INSERT INTO
  "ZKEYWORD"
VALUES
  (12, 'St. James''s Park');

INSERT INTO
  "ZKEYWORD"
VALUES
  (25, 'Stock Photography');

INSERT INTO
  "ZKEYWORD"
VALUES
  (10, 'Top Shot');

INSERT INTO
  "ZKEYWORD"
VALUES
  (33, 'Travel');

INSERT INTO
  "ZKEYWORD"
VALUES
  (29, 'UK');

INSERT INTO
  "ZKEYWORD"
VALUES
  (23, 'United Kingdom');

INSERT INTO
  "ZKEYWORD"
VALUES
  (20, 'Vacation');

INSERT INTO
  "ZKEYWORD"
VALUES
  (37, 'Val d''Isère');

INSERT INTO
  "ZKEYWORD"
VALUES
  (36, 'Wine');

INSERT INTO
  "ZKEYWORD"
VALUES
  (35, 'Wine Bottle');

INSERT INTO
  "ZKEYWORD"
VALUES
  (24, 'close up');

INSERT INTO
  "ZKEYWORD"
VALUES
  (9, 'colorful');

INSERT INTO
  "ZKEYWORD"
VALUES
  (8, 'design');

INSERT INTO
  "ZKEYWORD"
VALUES
  (27, 'display');

INSERT INTO
  "ZKEYWORD"
VALUES
  (26, 'fake');

INSERT INTO
  "ZKEYWORD"
VALUES
  (13, 'flower');

INSERT INTO
  "ZKEYWORD"
VALUES
  (5, 'flowers');

INSERT INTO
  "ZKEYWORD"
VALUES
  (32, 'foo/bar');

INSERT INTO
  "ZKEYWORD"
VALUES
  (22, 'kids');

INSERT INTO
  "ZKEYWORD"
VALUES
  (4, 'outdoor');

INSERT INTO
  "ZKEYWORD"
VALUES
  (1, 'photography');

INSERT INTO
  "ZKEYWORD"
VALUES
  (18, 'plastic');

INSERT INTO
  "ZKEYWORD"
VALUES
  (31, 'raw-only');

INSERT INTO
  "ZKEYWORD"
VALUES
  (28, 'stock photo');

INSERT INTO
  "ZKEYWORD"
VALUES
  (6, 'vibrant');

INSERT INTO
  "ZKEYWORD"
VALUES
  (17, 'we');

INSERT INTO
  "ZKEYWORD"
VALUES
  (21, 'wedding');

CREATE INDEX Z_Keyword_byTitleIndex ON ZKEYWORD (ZTITLE COLLATE BINARY ASC);

CREATE UNIQUE INDEX Z_Keyword_UNIQUE_title ON ZKEYWORD (ZTITLE COLLATE BINARY ASC);

CREATE INDEX Z_Keyword_title ON ZKEYWORD (ZTITLE COLLATE BINARY ASC);

CREATE TABLE "ZGENERICALBUM" (
  "Z_PK" INTEGER,
  "ZKIND" INTEGER,
  "ZTRASHEDSTATE" INTEGER,
  "ZTITLE" VARCHAR,
  PRIMARY KEY ("Z_PK")
);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (1, 3998, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (2, 3999, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (3, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (4, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (5, 2, 0, 'Pumpkin Farm');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (6, 1621, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (7, 1613, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (8, 1615, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (9, 3573, 0, 'progress-fs-import');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (10, 1627, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (11, 3571, 0, 'progress-sync');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (12, 1605, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (13, 1628, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (14, 1623, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (15, 1626, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (16, 1622, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (17, 1611, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (18, 1608, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (19, 1552, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (20, 4006, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (21, 1606, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (22, 1625, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (23, 4002, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (24, 4001, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (25, 1607, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (26, 1624, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (27, 1609, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (28, 1612, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (29, 1618, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (30, 1602, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (31, 1614, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (32, 1600, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (33, 4003, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (34, 1617, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (35, 1619, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (36, 1610, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (37, 4005, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (38, 1616, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (39, 4004, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (40, 1620, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (41, 3572, 0, 'progress-ota-restore');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (42, 2, 0, 'Test Album');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (43, 2, 0, 'Test Album');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (44, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (45, 4000, 0, 'Folder1');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (46, 4000, 0, 'SubFolder1');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (47, 4000, 0, 'SubFolder2');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (48, 2, 0, 'AlbumInFolder');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (51, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (52, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (53, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (54, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (55, 2, 0, 'Raw');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (56, 4000, 0, 'Folder2');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (57, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (58, 2, 0, 'EmptyAlbum');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (59, 2, 1, 'I have a deleted twin');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (60, 2, 0, 'I have a deleted twin');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (61, 4000, 0, 'Pumpkin Farm');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (62, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (63, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (
    64,
    2,
    0,
    '2018-10 - Sponsion, Museum, Frühstück, Römermuseum'
  );

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (65, 2, 0, '2019-10/11 Paris Clermont');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (66, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (67, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (68, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (69, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (70, 1506, 0, NULL);

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (71, 2, 0, 'Multi Keyword');

INSERT INTO
  "ZGENERICALBUM"
VALUES
  (72, 1630, 0, NULL);

CREATE TABLE "ZPERSON" (
  "Z_PK" INTEGER,
  "ZFULLNAME" VARCHAR,
  PRIMARY KEY ("Z_PK")
);

INSERT INTO
  "ZPERSON"
VALUES
  (3, 'Maria');

INSERT INTO
  "ZPERSON"
VALUES
  (5, 'Katie');

INSERT INTO
  "ZPERSON"
VALUES
  (6, 'Suzy');

INSERT INTO
  "ZPERSON"
VALUES
  (7, 'Suzy');

INSERT INTO
  "ZPERSON"
VALUES
  (8, 'Katie');

INSERT INTO
  "ZPERSON"
VALUES
  (12, '');

INSERT INTO
  "ZPERSON"
VALUES
  (13, '');

INSERT INTO
  "ZPERSON"
VALUES
  (14, '');

INSERT INTO
  "ZPERSON"
VALUES
  (15, '');

INSERT INTO
  "ZPERSON"
VALUES
  (16, '');

INSERT INTO
  "ZPERSON"
VALUES
  (17, '');

INSERT INTO
  "ZPERSON"
VALUES
  (18, '');

INSERT INTO
  "ZPERSON"
VALUES
  (19, 'Maria');

CREATE TABLE "ZDETECTEDFACE" (
  "Z_PK" INTEGER,
  "ZISINTRASH" INTEGER,
  "ZASSET" INTEGER,
  "ZPERSON" INTEGER,
  PRIMARY KEY ("Z_PK")
);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (1, 0, 4, 7);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (2, 0, 4, 5);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (3, 0, 2, 5);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (4, 0, 2, 13);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (5, 0, 3, 3);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (6, 0, 5, 5);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (7, 0, 2, 7);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (8, 0, 15, 19);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (9, 0, NULL, 5);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (10, 0, NULL, 5);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (11, 0, NULL, 7);

INSERT INTO
  "ZDETECTEDFACE"
VALUES
  (12, 0, NULL, 7);

CREATE INDEX ZDETECTEDFACE_ZASSET_INDEX ON ZDETECTEDFACE (ZASSET);

CREATE INDEX ZDETECTEDFACE_ZPERSON_INDEX ON ZDETECTEDFACE (ZPERSON);

CREATE TABLE "Z_27ASSETS" (
  "Z_27ALBUMS" INTEGER,
  "Z_3ASSETS" INTEGER,
  "Z_FOK_3ASSETS" INTEGER,
  PRIMARY KEY ("Z_27ALBUMS", "Z_3ASSETS")
);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (5, 4, 2048);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (5, 5, 3072);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (5, 2, 1024);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (43, 4, 2048);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (42, 5, 2048);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (48, 8, 2048);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (48, 3, 3072);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (55, 9, 2048);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (55, 10, 3072);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (55, 11, 4096);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (55, 12, 5120);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (60, 3, 2048);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (64, 8, 2048);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (65, 8, 2048);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (71, 3, 2048);

INSERT INTO
  "Z_27ASSETS"
VALUES
  (71, 5, 3072);

CREATE INDEX Z_26ASSETS_Z_34ASSETS_INDEX ON "Z_27ASSETS" (Z_3ASSETS, Z_27ALBUMS);

CREATE INDEX RADAR_22158684_INDEX ON "Z_27ASSETS" (Z_27ALBUMS, Z_FOK_3ASSETS, Z_3ASSETS);

CREATE INDEX RADAR_10322662_INDEX ON "Z_27ASSETS" (Z_27ALBUMS, Z_3ASSETS, Z_FOK_3ASSETS);

CREATE INDEX Z_26ASSETS_Z_3ASSETS_INDEX ON "Z_27ASSETS" (Z_3ASSETS, Z_27ALBUMS);

CREATE INDEX Z_27ASSETS_Z_3ASSETS_INDEX ON Z_27ASSETS (Z_3ASSETS, Z_27ALBUMS);

CREATE TABLE "Z_1KEYWORDS" (
  "Z_1ASSETATTRIBUTES" INTEGER,
  "Z_38KEYWORDS" INTEGER,
  PRIMARY KEY ("Z_1ASSETATTRIBUTES", "Z_38KEYWORDS")
);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (7, 29);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (7, 15);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (7, 30);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (7, 23);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (7, 7);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (7, 12);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (2, 3);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (5, 3);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (6, 21);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (1, 3);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (4, 3);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (3, 21);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (3, 5);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (15, 21);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (16, 32);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (17, 33);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (19, 33);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (6, 34);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (21, 36);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (21, 37);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (21, 38);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (21, 35);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (22, 37);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (22, 36);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (22, 35);

INSERT INTO
  "Z_1KEYWORDS"
VALUES
  (22, 38);

CREATE INDEX Z_1KEYWORDS_Z_37KEYWORDS_INDEX ON Z_1KEYWORDS (Z_38KEYWORDS, Z_1ASSETATTRIBUTES);

CREATE INDEX Z_1KEYWORDS_Z_36KEYWORDS_INDEX ON Z_1KEYWORDS (Z_38KEYWORDS, Z_1ASSETATTRIBUTES);

CREATE INDEX Z_1KEYWORDS_Z_38KEYWORDS_INDEX ON Z_1KEYWORDS (Z_38KEYWORDS, Z_1ASSETATTRIBUTES);
