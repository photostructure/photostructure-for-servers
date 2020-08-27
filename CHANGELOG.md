
Please note that this is a fairly exhaustive list of changes per version.

- Major releases have more expository posts that describe new features, like our
  [**version 0.8**](/about/v-0-8/) post.

- Visit [**what's next**](https://photostructure.com/about/whats-next/) to get a
  sneak-peak into what we're going to be working on next (and don't forget to
  share your feedback with us!)

## v0.8.4

_Not released yet_

#### Features & enhancements

- ✨ First step towards retroactive [NoMedia](/nomedia) file exclusions: a new
  `PS_EXCLUDE_NO_MEDIA_ASSETS_ON_REBUILD` library setting (that defaults to
  `true`) allows assets to be "excluded" from your library if _any_ file that
  was already imported is found to be in a [NoMedia](/nomedia) directory.

- ✨ UNC paths (`\\server\share\path\to\file.jpg`) are now supported both for
  libraries and for scan paths.

- ✨ The "show streams" button on the asset page is now iconic (rather than just
  a down arrow), with busy and close states (which should help discoverability
  of asset streams)

- ✨ Transcoded video encoded max bitrates are now configurable via
  `PS_TRANSCODE_BITRATE_QVGA` and `PS_TRANSCODE_BITRATE_UHD`. Videos with
  resolutions between QVGA and UHD will lerp between these values.

- ✨ For MacPorts users: a new `PS_TOOL_PATHS` setting is now configurable, and
  now includes `/opt/local/bin` on Linux and macOS.

- 💔 The `PS_FORCE_LOCAL_DB_REPLICA` setting is now on by default for Docker
  users. This caused issues with a bunch of beta users, and having it on when
  not needed only makes shutdown a bit slower (as the database needs to be
  copied back into the library).

- ✨ Volume UUID reading and writing is now configurable via Settings.

- ✨/🐛 The default value of `PS_FUZZY_DATE_IMAGE_CORR_WEIGHT` was changed from
  1.2 to 1.5. This makes PhotoStructure much more discriminating when it
  de-duplicates photos that don't have a precise date (like from scanned
  images).

- 📦 Header components are removed or reduced on mobile to prevent title
  overlaps

- 📦 Release notes are now available from the main navigation menu from
  within PhotoStructure, as well as the footer on photostructure.com pages.

#### Bug fixes

- 🐛 **Non-English locale support**: Users whose system locale was not
  "`POSIX`" may have seen a number of different bugs, including failure to
  launch. PhotoStructure now forces locale on forked tools to `C` which should
  address this issue.

- 🐛 Fixed AssetFile URI encoding errors for paths that had special characters

- 🐛 Filenames with certain non-latin or characters may have been importable
  before due to URI parsing bugs. This should now be addressed: run "sync" if
  you think you may have been impacted.

- 🐛 string comparisons are now locale-sensitive.

- 🐛 Fixed system icon tooltip text (it said `function () { ...`)

- 🐛 The [`info` tool](/server/tools/) no longer elides deep object fields

- 🐛 Added more robust race-condition handling for file caches (this mostly
  impacted high-cpu-count systems)

- 🐛 Binary keyword fields are now properly ignored (instead of interpreting
  `(Binary data 32 bytes, use -b option to extract)` as a _keyword_, oops!).

#### Performance enhancements

- ✨/🐛 More types of unhealthy volumes are now ignored, rather than preventing
  PhotoStructure from starting.

- ✨ Several new binary thumbnail variants are now inspected, which can speed up
  imports of certain RAW images.

## v0.8.3

**Released 2020-07-29**

Every feature and bug fix in this release is directly due to beta users'
suggestions or their assistance. Thank you!

- 💔 The `PS_REQUIRE_MAKE_MODEL` setting is now **disabled by default**. This
  filter, when enabled, prevents PhotoStructure from importing files that don't
  have a Make or Model tag, which prevents images like screenshots from filling
  up your library. Unfortunately, this also prevents images downloaded from
  Facebook/Instagram, and SMS. So far **no** beta users have wanted this enabled
  once they learned of the setting, which might be a good clue that the default
  was bad.

- ✨/🐛 Improved the reliability of date extraction for photos and videos that
  have no dates in their metadata. Two new settings were added,
  `PS_USE_PATHS_TO_INFER_DATES`, and `PS_FUZZY_DATE_PARSING`, which can be used
  to disable PhotoStructure's default behavior that attempts to extract
  captured-at times from paths when metadata is missing from the asset, and to
  use more relaxed date parsing.

- ✨ De-duping greyscale images has been improved. If you have a number of
  greyscale photos in your library, please run `rebuild` to regroup your
  library's assets.

- ✨ De-duping of files without precise dates has been improved by requiring more
  stringent image correlation. This is controlled by the
  `PS_FUZZY_DATE_IMAGE_CORR_WEIGHT` setting.

- ✨ Added new `PS_STRICT_DEDUPING` library setting. Set to true if you don't want
  image edits to be grouped together with raw images. NOTE: This will most
  likely cause RAW and JPEG pairs to not always merge to the same asset,
  especially if your camera uses extensive computational imagery.

- ✨ When viewing an asset, the automatic header and button hiding-on-idle is now
  disabled whenever the asset info panel is shown (thanks to beta users for the
  suggestion!)

- ✨ Library rebuilds now report on the files that are being processed.

- 🐛 Zombie prevention within Docker: The Dockerfile now use `tini` as the default `ENDPOINT`,
  which reaps zombie processes properly. The docker image is a bit larger now,
  but we don't have to rely on users using `--init` (only available on more
  recent versions of Docker or Docker Compose).

- 🐛 System settings are now written on startup if outdated or missing

- 🐛 If PhotoStructure rebuilt a portion of your library every time you
  restarted, this should be fixed now. We were trying to rebuild missing files,
  but we'll update those files when they re-appear.

- 🐛 A race condition in the image cache that could prevent assets from being
  imported was fixed.

- 🐛 Non-default array settings (like `PS_PREVIEW_RESOLUTIONS`) are now
  correctly handled

- ✨/🐛 Suggested library directories are removed if they are not writable

- ✨/🐛 On Windows, we now read from the system registry to get the user's
  Pictures directory.

- ✨/🐛 Improved date parsing for file basenames to require year, month, and day
  (prior versions would interpret an image with no metadata named "1958.jpg" as
  coming from the year 1958 (!!)).

- ✨/🐛 Logging errors in v0.8.2 would cause the prior only-held-in-RAM logs to
  get flushed to disk (to help debug issues later). Unfortunately, several
  fairly common things were being logged as errors (rather than warnings), which
  caused logs to get big quickly. These have been addressed.

- ✨/🐛 Renamed the `ls` tool to `list`. This tool now has `--dirname` and
  `--orderby` parameters.

- 📦 Added [documentation for tools](/server/tools/).

- 📦 Added instructions for installing PhotoStructure for Node on Windows 10.

- 📦 Enabled tree-shaking in the front-end javascript build (size dropped from
  260KiB to 218KiB).

- ✨/🐛 PowerShell is now spun up with `-NoLogo`, which may allow profile scripts
  that are slow to pass desktop pre-flight checks.

- ✨/🐛 v0.8.1 and v0.8.2 had different versions of `sharp` between the Desktop
  and Server editions of PhotoStructure, which could result in slightly
  different image hashes. The version is now consistent across editions.

- 📦 The docker `WORKDIR` is now `/ps/app`, so running commands ad-hoc are the
  same as on PhotoStructure for Node: just `docker exec -it photostructure sh`
  and then `./photostructure --help` or `./photostructure info`.

- 🐛 `logcat` handles very large inputs now.

- 🐛 The cache directory wasn't clearing fast enough in v0.8.2. The "vacuum"
  process would eventually run, but caches could grow to 20gb on a fast enough
  machine under prior default settings. The cache time has been reduced by 3/4
  and the vacuum is scheduled to run more often.

## v0.8.2

**Released 2020-07-11**

- 🐛 [NoMedia](faq/how-to-hide-directories/) directories weren't respected. They are now only cached for a minute.

- ✨ Filesystem metadata (including UUID and NoMedia) is cleared when you pause
  and then resume the library import and sync processes (available via the
  system tray or system navigation menu).

- ✨ Service setup has a timeout to prevent zombie processes. This timeout can
  now be overridden with the `PS_SETUP_TIMEOUT_MS` environment variable.

- 🐛 Added a per-volume timeout to gracefully handle mountpoints that are in an
  unhealthy state (which is fairly common on Windows).

- 🐛 Lens metadata matching "unknown" is now ignored.

- 🐛 NFS remote mountpoint metadata is now parsed correctly.

## v0.8.1

**Released 2020-07-09**

[**See our v0.8 version announcement**](/about/v-0-8/)

#### General updates

✨ 🧭 **Easier navigation**

Click the new navigation button in the top-left part of the screen for access to

- Root tags, like "When," "Camera," "Keywords," and "File Type"
- The About and Settings pages
- Links to control the sync process and shut down PhotoStructure
- The getting started and support pages on <PhotoStructure.com>

PhotoStructure for Servers users: this gets you to feature parity with Desktop
users that have enjoyed these links in their system tray menu.

PhotoStructure for Desktop users on Linux and Windows: hit the <key>alt</key> key to see
your new menu bar.

✨ 🚅💨 **Faster sync**

Library synchronization is much faster in this release.

In prior versions, PhotoStructure watched CPU utilization and only scheduled new
work when your system was "idle enough." In practice, this resulted in
under-scheduling. On slower or busier systems, imports ran so slowly that they
didn't complete.

PhotoStructure now runs all child processes with a
[nice](https://en.wikipedia.org/wiki/Nice_%28Unix%29) or
[BelowNormal](https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.processpriorityclass?view=netframework-4.8)
priority level. This allows your operating system schedule work much more
efficiently. Your system should remain responsive while simultaneously running
synchronization tasks substantially faster, especially on multi-core systems.

The new `cpuLoadPercent` and `processPriority` settings allow for tuning this behavior.
Please email us (hello@photostructure.com) if you need to tweak the defaults for
your system.

✨ 💽💨 **Faster writes**

Prior versions serialized all database writes through the web process. This
slowed down writes, and could make the UI less responsive during imports.

PhotoStructure now uses SQLite's WAL mode to allow all processes to write
directly to the database. This speeds up writes as well as allows the web UI to
stay responsive, even during imports.

✨ 📹💨 **Faster video transcodes**

If you're importing videos, and you're using FFmpeg, we now import videos in
parallel, which can substantially improve import speeds. VLC does not support
parallel imports. See our [video installation
instructions](/getting-started/video-support/) for more details.

✨ 💪 **More robust error handling in the UI**

While browsing, if an asset is found that can't be rendered due to an incomplete
import, unmounted filesystem, or any other error, PhotoStructure will redirect
you to the nearest valid asset as you browse while it runs a background repair
job to try to fix the asset.

✨ 📨 **More download options**

The asset info panel now lets you download the original, large, medium, and
small resized versions of your images. These smaller versions are handy for emails or
texts, and are available on the first asset file's `⋮` button.

✨ 📹 **Video support improvements**

Video duration and FPS, if available, are now shown in the Asset Info panel.
Duration and FPS will need to be backfilled for all videos in your library, and
will happen automatically after you upgrade to this version.

Transcoding is (by far!) the most expensive operation that PhotoStructure has to
do during the import process, and has been refined in this new released. Previous
versions transcoded all videos not in `video/mp4` format.

PhotoStructure now provides a
[setting](/getting-started/advanced-settings/#library-settings),
`doNotTranscodeMimetypes`, which adds three more commonly-supported video types
to avoid transcoding (as most browsers on most OSes can natively render them).

✨ 🔄 **More robust rotation support**

When you rotate your photos or videos with PhotoStructure, it now applies image
content matching to ensure **all asset file variants** for the asset you rotated
are in the same visual orientation.

Note that rotation is a non-destructive operation by writing a sidecar with the
orientation next to your original. This behavior can be changed to edit in place
with an [advanced library
setting](/getting-started/advanced-settings/#library-settings).

✨ 🏷️ **Hierarchical keyword support**

PhotoStructure now extracts hierarchical keywords from `Categories`, `TagsList`,
`LastKeywordXMP`, `HierarchicalSubject`, `CatalogSets`, and `Subject` tags.

For non-hierarchical keyword sources, like pathnames, PhotoStructure splits by
commas and semicolons. For example, `car, blue, tree` will be interpreted as
having the keywords `car`, `blue`, and `tree`. This is configurable via the
`keywordDelimiters` setting.

PhotoStructure interprets keywords as “heirarchies”, or “paths”, when a keyword
includes one or more of the characters `/`,`|`,`>`,`≻`, or `⊃`. Note that on
windows, there can be issues with filenames that have forward slashes, vertical
bars, or greater-than characters, so use the alternatives. This allows for tags
like `Family|Einstein|Albert`, `Flora ⊃ Fruit ⊃ Orange`, or
`Fauna > Oceanic > Pelican`. This is configurable via the new
`keywordPathSeparators` setting.

✨ 🌍🌏🌎 **Better unicode support**

Filenames and directories with non-latin characters should now be supported
properly.

#### More frontend updates

- ✨ 🔎 New [zoom loupe control](/zoom)
- ✨ 💬 Chat widget on the settings and about pages, to get just-in-time help
  from our global team of friendly customer service agents (ok, it's just me)
- ✨ The settings page now shows which suggested library paths are already PhotoStructure libraries.
- ✨ **See your dupes**: You can now view all Asset variants on both mobile and
  desktop views. Open the Asset info panel, and click on the pathname to view
  that file's image. If the image is RAW, it will be converted to JPG so your
  browser can render it.
- ✨ Asset streams are centered around the current asset now.
- 🐛 On some mobile browsers, child tags and assets didn't always lazy-load. A
  `Load More ...` button now shows when needed.
- ✨ The Asset Streams panel on the bottom no longer overlays on the current
  photo.

#### Tagging improvements

- 📦 The cache directory on linux is now `~/.cache/PhotoStructure`. It had
  previously been in `/tmp`. This can be changed via the `PS_CACHE_DIR`
  environment variable, or the `cacheDir` [system
  setting](/getting-started/advanced-settings/#system-settings).
- ✨ All taggers can be enabled or disabled via new library settings.
- ✨ New `Type` tag, so you can view all videos, or all images of a specific type
  (see `tagType`).
- ✨ Date tagging can be "year", "year/month", or "year/month/day" (see
  `tagYMD`).
- ✨ Date tagging can be limited to only non-`stat` values (see
  `tagDateFromStat`).
- ✨ Lens tagging can use the full lens model (like "Canon EF-M 15-45mm f/3.5-6.3
  IS STM") or a just the lens information ("15-45mm f/3.5-6.3") (see
  `tagFullLensModel`).

#### Backend improvements

- ✨ New "Rebuild library" option from the navigation menu.
- ✨ sidecar files use the full filename now, so image "pairs" (like JPG +
  RAW) can have differing metadata values. For example, for `IMG_123.JPG`, both
  `IMG_123.XMP` and `IMG_123.JPG.XMP` will be considered relevant sidecars for
  that file, and the enclosed metadata tags will be overlayed on the original
  image in order of newest-written-file-wins.
- 🐛 RAW image dimensions should be more accurate now.
- 🐛 Paths can now have non-latin characters.
- 🐛 Unicode keywords (both in ICMP/EXIF headers and in pathnames) are now
  supported.
- 🐛 Prior versions could persist settings that were set by command-line
  arguments or environment variables making it the new “default” value. If you
  had problems with the settings page not saving your values, this should fix
  that.
- 🐛 If an asset doesn't have a metadata-encoded captured-at, we now infer the
  captured-at from the basename (if the file is named something like YYYYMMDD),
  and if no date is found in the basename, we examine the parent directory path.
- ✨ Improved make and model parsing for more cameras and smartphones.
- ✨ Image hashing has been sped up dramatically for images that have embedded
  thumbnails. Most original JPEG and RAW images have these thumbnails.
- ✨ Dominant color extraction is faster, more accurate, and dominant color
  comparisons now use more accurate color perception correlation.
- ✨ Idle background tasks, like `exiftool` and `sync-file` are shut down
  automatically when they are idle to reduce system resource consumption.

#### PhotoStructure for Servers updates

- 💔 The `start-docker.sh` and `photostructure.env` scripts have been deleted.
  No beta users (to my knowledge) used them, `docker-compose` changed their
  configuration format arbitrarily and had a questionable installation
  procedure, so it felt like it was just more moving pieces just to support
  upgrades. (If you want easy image upgrades, try <https://www.portainer.io/>!).
  The instructions for Docker have been rewritten and are much simpler to follow.
- 💔 The `PS_CONFIG_DIR` is now directly written to. Prior versions would write
  to `$PS_CONFIG_DIR/PhotoStructure`, which was surprising to several beta
  users. Please `mv $PS_CONFIG_DIR/PhotoStructure $PS_CONFIG_DIR` before
  upgrading your image.
- ✨ Node.js version 12 and version 14 are now supported. 12 is now the minimum.
- ✨/📦 PhotoStructure for docker now uses Node.js v14 and Alpine. This dropped
  the image size from 1.5GB to 300M.
- 🐛/💔 Alpha, beta, and release builds post to different git branches and
  different docker tags now. Previously, PhotoStructure for Servers users pulled
  in the latest build, which might have been an alpha or beta pre-release.
- ✨ Instructions for building `libvips` (required to support `.heic`) were added
  to the README. Note that the docker image does _not_ support `.heic`/HEVC, due
  to licensing and patent restrictions. **Tell Apple to switch to AV1!**
- 📦 For PhotoStructure for Node users, if the version of PhotoStructure or
  Node.js changes between runs, `./start.sh` automatically rebuilds
  `node_modules` as required.

## Prior releases

Please see the [**release notes from 2019**](/about/2019-release-notes)
