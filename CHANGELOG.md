
## v0.8.0 _(work in progress)_

_Expected release: May 2020_

[**See our v0.8 version announcement**](/about/v-0-8/)

#### General updates

✨ 🧭 **Easier navigation**

Click the new top-left navigation button for access to

- Root tags, like "When," "Camera," "Keywords," and "File Type"
- The about and settings pages
- Links to control the sync process and shut down PhotoStructure
- The getting started and support pages on photostructure.com

PhotoStructure for Servers users: this gets you to feature parity with Desktop
users that have enjoyed these links in their system tray menu.

PhotoStructure for Desktop users on Linux and Windows: hit the <key>alt</key> key to see
your new menu bar.

✨ 🚅💨 **Faster sync**

[TL;DR](https://en.wiktionary.org/wiki/too_long;_didn%27t_read#English): Library
synchronization runs much faster now.

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
could make the UI lag during imports. PhotoStructure now uses the new SQLite WAL
mode to allow all processes to write directly to the database.

✨ 📹💨 **Faster video transcodes**

If you're importing videos, and you're using FFmpeg, we now import videos in
parallel, which can substantially improve import speeds. Note that VLC does not
support parallel imports. See our [video installation
instructions](/getting-started/video-support/) for
more details.

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

#### More backend updates

- ✨ New "Rebuild library" option from the navigation menu.
- 📦 The cache directory on linux is now `~/.cache/PhotoStructure`. It had
  previously been in `/tmp`. This can be changed via the `PS_CACHE_DIR`
  environment variable, or the `cacheDir` [system
  setting](/getting-started/advanced-settings/#system-settings).
- ✨ New `Type` tag, so you can view all videos, or all images of a specific type.
- ✨ Date tags can include day now. See the [library
  settings](/getting-started/advanced-settings/#library-settings)
  file.
- ✨ All taggers can be enabled or disabled via new library settings.
- ✨/💔 sidecar files use the full filename now, so image "pairs" (like JPG +
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

- ✨ Instructions for building `libvips` (required to support `.heic`) were added
  to the README. Note that the docker image does _not_ support `.heic`/HEVC, due
  to licensing and patent restrictions. **Tell Apple to switch to AV1!**
- 📦 If the version of Node.js changes between runs, `./start.sh` automatically
  rebuilds `node_modules` as required.

## v0.7.2

**Released 2019-12-12**

- ✨ Added a link to the post-install tips in the "starting up" message
- ✨ Platform-default "back" and "forward" keystrokes now work for PhotoStructure
  for Desktops. On macOS, cmd-left and cmd-right to go back and forward, and on
  Windows and Ubuntu, alt-left and alt-right do the same.
- 🐛 The settings page doesn't submit if the user hits the `enter` key anymore
- 🐛 Forced scrollbar to render on the info panel
- 🐛 Removed duplicate and bad library path suggestions in the welcome page
- ✨ `photostructure web` now accepts a `--expose` argument. See `--help` for all
  options.
- 🐛 library settings now correctly pass through non-default values.
- 🐛 Browsing via Firefox would sometimes raise `SIGPIPE`s. These are handled
  gracefully now.

## v0.7.1

If you automatically upgraded to this version, you'll need manually install
v0.7.2, as this version never exits the splash screen.
[Apologies](https://twitter.com/PhotoStructure/status/1205335353210441729)!

## v0.7.0

**Released 2019-12-11**

#### 💔 Settings changes

A number of settings were moved from the library settings file to the server
settings file. **This migration should happen automatically** after you update
your version of PhotoStructure (on all platforms). The affected settings are:

- `copyAssetsToLibrary`
- `scanAllDrives`
- `scanMyPictures`
- `scanPaths`

More information about [changing advanced settings has been added to the support
site](https://support.photostructure.com/advanced-settings/).

#### Automatic upgrades on Windows and Linux

Automatic upgrades may have broken for some users on Windows and Linux.

Please manually download and install the newest version. You don't need to
uninstall the previous version beforehand. Sorry for the inconvenience!

#### Scan path improvements

- ✨ The custom scan paths field on the settings page now natively supports
  multiple paths, and both os-specific delimiters (like `:` or `;`) as well as
  `¦` may be used (in case directories include the delimiter character).

#### PhotoStructure for Servers, take 2

If you're a PhotoStructure for Docker user, please fetch new copies of the
`photostructure.env` and `start-docker.sh` files. A bunch of new stuff is in
this version:

- ✨ The `SCAN_PATH` value in `photostructure.env` used to be a colon-separated
  value, but this is now a proper bash array. This supports paths that have
  colons in their names (like SMB mounts via GIO). Update your copy of
  `photostructure.env` by following the instructions at
  <https://support.photostructure.com/photostructure-for-docker/>.

- ✨ The `start-docker.sh` script now automatically updates. If you already
  started using PhotoStructure for Docker, you'll need to manually fetch a new
  copy by following the instructions at
  <https://support.photostructure.com/photostructure-for-docker/>.

- ✨ The `PS_TMP_DIR` scratch directory is now configurable, and should point to
  a fast scratch disk with several gigabytes free on the host machine. This is a
  new variable in `photostructure.env`, and should be set properly to prevent
  container bloat and possible Docker crashes.

- ✨ `PS_*` environment variables, set either in your `photostructure.env`
  or set in the `env` of the shell that is calling `start-docker.sh`, are now
  passed through to Docker.

- ✨ `start-docker.sh` now accepts an argument, which is passed through to
  `docker-compose`:

  - To run the services in the background (and ctrl-c to stop), run `start-docker.sh start`. This is the default.
  - To run the services in the foreground (and ctrl-c to stop), run `start-docker.sh up`.
  - To just view the resulting `docker-compose.yml` and not start services, run `start-docker.sh config`.
  - To stop services, run either `docker-compose stop` or `start-docker.sh stop`.

- 🐛 The settings page no longer allows the library path to be changed when
  running under docker. Instead, the library path should be changed in
  `photostructure.env` and `start-docker.sh` should be re-run.

#### Additional keyword extractors

✨ Tags found in filenames or parent directories that follow `--` are now added
automatically. If you already have a library, run a full sync to pull in these
new tags. Here are a couple examples:

- All files found in the `/Users/bob/Pictures/2019-02-14/--event travel/`
  directory would be tagged with `Keyword/event` and `Keyword/travel`.
- The file `/home/karen/2018-11-23/P317812--ocean.jpg` would be tagged with
  `Keyword/ocean`.
- Filename tags can be hierarchical by using the `keywordPathSeparators`
  setting: for example, `/home/alice/Pictures/--event>wedding,/example.jpg`
  would be tagged with `Keyword/event/wedding`.

**Bug fixes**

- 🐛 Thumbnails for vertical videos are now correctly oriented and scaled.

- 🐛/✨ Symlink loops in filesystems are detected and skipped over (even on NAS!).

- 🐛 Main process error handling now respects the error rate setting, which
  defaults to 10 per minute. Prior versions would shut down PhotoStructure
  completely if any subprocess threw a fatal error.

- 🐛 The new "Starting sync..." and "Your library is currently empty" messages
  on the home page linked to the About window, but clicking that link didn't
  work correctly. The link now correctly opens the about window in a separate
  page.

- 🐛 The "Restart sync" menu items were incorrectly ~~greyed (grayed?) out~~
  disabled even after a library was set up. They are enabled after going through
  the welcome screen, now.

- ✨ PhotoStructure's temp directory is cleaned every 15 minutes. Some beta
  testers had disk-full warnings with the prior settings of cleaning only every
  hour.

- 🐛/✨ Some Windows beta testers had configured their PowerShell to emit
  profiling information at startup, which prevented several systems from running
  properly. We now use both `-NoProfile` and `-NoLogo` options which should help
  PowerShell spin up faster. We also validate PowerShell's status as a health
  check on Windows, and include the PowerShell version in the About window. Note
  that PowerShell is used to copy files if native streaming methods fail, as
  well as test directories to see if they are hidden, as well as pulling
  filesystem and process table metadata.

- ✨ All dependencies were updated. Electron was updated for PhotoStructure for
  Desktop.

## v0.6.2

**Released 2019-11-23**

- 🐛 On web restart-on-error, prior library lock is released by main before
  restarting web. This resolves the "Library is already open" crash bug.
- 🐛 Sync restarts properly when settings are changed (including the library
  path)
- 🐛 Under certain circumstances, library paths could be removed from system
  settings, resulting in the welcome page being shown if PhotoStructure was
  restarted. This has been fixed.
- 🐛 Main process logs weren't initialized correctly, preventing log
  persistence.
- 🐛 Downgraded Electron to 7.1.1 (may avoid new SIGSEGV from 7.1.2 on mac)
- 🐛 Extended filesystem timeout from 25 seconds to 35 seconds (external drives
  can be very slow to spin up!)
- ✨ Files that are found to be missing (and their mountpoint or parent directory
  still exists) are removed from the db, orphaned assets are subsequently
  removed from the library.
- ✨ Fixed grammar in progress bars
- ✨ Files that have been deleted are now removed from the db as well
- ✨ Assets that no longer have files associated to them are removed
- ✨ `Download` and `Downloads` directories are now automatically ignored.
- ✨ `.photoslibrary` subdirectories are now ignored, except for `Masters`.

## v0.6.1

**Released 2019-11-21**

- 🐛 Window buttons on settings work within Electron
- 🐛 Electron updates were re-enabled for Linux AppImages

## v0.6.0

**Released 2019-11-20**

Please note that this version will require revisiting the files in your library
to recompute metadata, compute image hashes, extract new lens and keyword tags,
and re-encode preview images as progressive JPEGs. This will happen
automatically after you upgrade PhotoStructure.

Thanks for your patience while PhotoStructure upgrades your library!

**💔 Breaking changes**

- **macOS is now notarized**. Official support for macOS 10.11-10.13 (El Capitan
  through Sierra) has been dropped (although it may still work for you). Note
  that El Capitan [hasn't received a security update for more than a
  year](https://support.apple.com/en-us/HT201222). 64-bit binaries are now being
  built and tested on macOS Mojave.

- Replaced the `maxPreviewResolution` library setting with `previewResolutions`.
  See the description of the setting for more details.

**🚀 Performance improvements**

- ✨ `ffmpeg`, if installed, is now used for frame extraction and transcoding
  instead of VLC (in preparation for PhotoStructure for Servers). You may find
  ffmpeg faster than VLC. See
  <https://support.photostructure.com/vlc-installation/> for more information.
- ✨ Preview images are progressively encoded now (see the `progressive` library
  setting, which defaults to `true`). This takes a bit more time, and can be
  disabled in Settings.
- ✨ Captured-at times are stored in local-numeric-centisecond format, rather
  than an ISO string. This takes a fraction of space compared to the prior
  format.
- ✨ Home page queries for large libraries in previous versions took upwards of
  500ms. The new `dbCacheSizeMb` system setting now defaults to 128 MB, which
  should handle large (quarter-million asset) libraries. If you have a larger
  library, double this value, and be sure to email us if you see anything else
  not run quickly.
- ✨ The webserver was profiled and several hotspots were inlined. Average
  request latency on average desktop CPUs should now be 10 ms or less.
- ✨ CSS assets are all concatenated now.
- ✨ All static assets are now gzip'ed and transferred compressed.
- ✨ Image lazy loading was profiled and optimized.
- ✨ Icons in prior version used a webfont, which caused flashes of unstyled
  text. All icons were replaced with inline SVG components. At least on Firefox
  and Chrome, initial page load times are measurably faster.
- 📦 Both frontend and backend code is now compiled to es2015 (rather than es5),
  which reduced payloads by > 10%.
- ✨ Web requests are prioritized over RPC synchronization requests by the
  webserver, which allows the web UX to stay performant even during sync
  processes.
- ✨ Non-mutating API calls from the frontend are retried (should help smooth
  over webserver restarts or glitchy networks).
- ✨ The `logtail` command now uses non-polling filesystem notifications (via
  `chokidar`), and orders log lines chronologically.

**💪 Robust de-duplication**

- ✨ PhotoStructure's photo and video merging algorithm was revisited in this
  version. The prior implementation used 2 hash comparisons, which failed to
  match after some lossy image and video transforms (like from cloud backups).
  The new implementation uses 10 different hash values, including several hashes
  based on actual image contents (using rotation-invariant L*a*b\* values, if
  you're interested). This (and lens and keyword tagging and better preview
  image generation and better video transcoding) is why this version requires
  prior libraries to be upgraded.

**🎥 Lens tagging**

- ✨ If a photo or video has lens metadata, that will be added as a tag, and
  is navigable via the new root tag, "Lens".

**🔄 Photo and video rotation**

- ✨ Added support for photo and video rotation. Click on an asset, and hit `r`
  (or the rotate icon in the header) to rotate counter-clockwise 90 degrees. Hit
  `r` or click the rotation icon multiple times in a row to rotate more than 90
  degrees. Saving happens in the background, and is non-destructive.
- 📦 The `writeMetadataToSidecars` library setting controls how the rotation
  metadata is persisted. The default is to save a new sidecar, or update an
  existing sidecar, with the new orientation.
- 📦 Asset thumbnails and preview images are now fetched with timestamp params.
  This allows the UI to stay in sync with the library database, and still cache
  images when appropriate. _Depending on the speed of your browser, you may see
  a flash of an incorrectly-rotated image immediately after rotating: we know,
  and we'll try to fix it in the next release._

**🔍 Zoom on desktop**

- ✨ When viewing an image full-screen, you can now type 'z', or single-click in
  the middle of the photo, click the new zoom icon in the upper right corner, or
  mousewheel-up to zoom into the image. Moving the mouse pans the position of
  the zoomed-in image. Mousewheel controls the scale of zoom. Typing 'z', the
  'esc' key, clicking in the middle of the screen, or clicking the zoom icon
  will return to normal mode.

**🔍 Zoom on mobile**

- ✨ To zoom into an image or video on a tablet or phone, just pinch out on the
  image. As you zoom in, higher resolution images will be loaded in-place of the
  current image to ensure the highest quality pixel peeping experience.

**📱 Responsive UI**

- ✨ The welcome/settings page is now responsive and usable from an iPhone SE to
  a 4k display.
- ✨ The header slides away on scroll-down (and sliding back on scroll-up),
  providing more screen real-estate on mobile devices.
- 🐛 The "fullscreen" button was removed. There were a couple scrolling bugs
  that don't seem to have nice workarounds, and the new hiding header makes this
  less pressing a feature on mobile.

**✨ General improvements**

- ✨ PhotoStructure for Desktop now has an application menu on macOS. YAY.
- ✨ Standard keystrokes for display zoom, copy, paste, and devtools now work.
- 🐛 Some people reported crashes on macOS after long (> 24 hour) sync runs.
  PhotoStructure now automatically restarts the sync process every 6 hours or if
  memory consumption exceeds 1GB, which should spackle over this issue.
- ✨ PhotoStructure now uses reverse-chronological order consistently. Photo
  streams had previously been chronological order, and tags were reverse-chron.
  Fixes #42.
- ✨ Image hashes are now used to coalesce similar assets that have had their
  metadata stripped.
- ✨ Excluding images due to missing Make or Model is now a Setting
- ✨ The `info` tool now reports explaining why 2 files would or wouldn't belong
  with the same asset
- 🐛/✨ Google Takeouts sometimes provides JSON sidecars with GPS and other
  metadata. PhotoStructure now knows how to read this sidecar metadata.
- 🐛/✨ Timeliner and other cloud storage solutions may provide edited versions
  of your images that are stripped of GPS tags. Prior ExifUID versions assumed
  GPS wouldn't be deleted.
- 📦 Asset counts for tags are formatted nicely for the user's locale (like
  "1,523 assets" for `en_US`)
- 📦 The Asset Info panel had links for downloading and for showing the asset
  file in the enclosing folder, but most users didn't know that those links
  existed. There's now a pulldown menu by each asset file path with those
  options.
- 📦 `showItemInFolder` now runs directly from the webserver.
- 🐛 `showItemInFolder` on Ubuntu could fail if there were network filesystems
  in a bad state. We ignore those errors now, so the Nautilus window can stay
  shown.
- 🐛 Network disconnections (due to system sleep or suspend) should no longer
  raise error dialogs.
- 📦 Added `**/tmp/**` to the directory exclusion filters. Previously only
  `/tmp` and `/var/tmp` root directories had been excluded.
- 📦 Ignore `**/com.apple.TimeMachine.localsnapshots` directories
- 📦 All third-party dependencies were updated, which pulled in several security
  patches, including SQLite 3.29.0.
- ✨ Database backups are automatically taken before every migration set is
  applied (to allow for recovery via customer support)

**✨ Customer support**

- ✨ The `about` window now supports copying system metadata to the clipboard,
  or emailing to support via a `mailto:`.
- ✨ `Send recent logs` from the system tray sends all currently-running process
  logs to Sentry.

## v0.5.1

**Released 2019-06-06**

- 📦 Directory iteration uses a new, much smaller (non-cached) class to track
  filesystem metadata. This should help reduce memory consumption while scanning
  large filesystems.
- 📦 Ignore `/nix/store/...` [directories](https://nixos.org/nixos/about.html)
- 📦 Support parsing folder names as dates that use `.` or `,` field separators
  (like `Pictures/2019.03.14/image.jpg`)
- 📦 Launching PhotoStructure automatically checks for updates now. This can be
  disabled with the `updateOnLaunch` system setting.
- 🐛 Random gallery contents no longer change every minute
- 🐛 Setting your `LANG` to `C` is supported (and considered a synonym for
  `en`).

## v0.5.0

**Released 2019-06-01**

Please note that this version will require a sync to revisit the files in your
library. This will happen automatically.

**✨ Synchronization improvements**

- ✨ **Sync runs periodically now**. After `sync` completes importing all
  available volumes, it waits for `syncIntervalHours` (configurable as a library
  setting), and restarts the sync process. This defaults to 24 hours, to balance
  picking up new files automatically and trying to avoid unnecessary wear and
  tear on your storage media.

- ✨ **Files are processed concurrently now**, depending on the number of CPUs
  your computer has. This may dramatically speed up sync.

- ✨ **Syncs of previously-imported volumes should complete faster now**,
  because files are only checked for changes every `fileSyncIntervalHours`
  (configurable as a library setting). This defaults to every week, again, to
  try to balance PhotoStructure being in sync with your storage media, and wear
  and tear on your disks.

- ✨ **NAS support for library storage**: Library lockfiles prevents NAS-stored
  libraries from being corrupted by multiple simultaneous writers (or multiple
  instances of PhotoStructure on one machine from fighting). If the lockfile is
  lost (if, for example, you unplug the NAS or the external drive that your
  library is on), PhotoStructure will shuts down automatically.

- ✨ **Multiple file asset support**: When there are multiple files representing
  a given asset, and the most-recent file is not available, next-most-recent
  candidates are now considered for preview generation and tagging purposes.

- ✨ **Keyword support**: Assets are tagged with keywords. Keywords are found in
  the `Keyword` IPTC tag and `XPKeyword` EXIF tag. Sidecars keywords are
  included as well.

- ✨ **Support for SD cards and smartphones:** In previous versions of
  PhotoStructure, local volumes that weren't available to `df`, or that didn't
  have UUIDs could cause... issues. OK, fine, they were 🐛. Unfortunately,
  smartphones, SD cards, and several other types of media don't reliably have
  UUIDs, so if PhotoStructure failed to launch (especially on Windows), this
  version may fix that for you.

- ✨ The `ExifUID` version was updated to support more original/edited pairs (as
  many photo editing apps will delete timezone offset metadata). Whenever a new
  ExifUID version is released, your next sync will need to visit all your assets
  again. **This should complete much faster than an initial sync.**

- 📦 `scanPaths` are scanned first, followed by `libraryPath`, followed by
  mounted volumes (if `scanAllDrives` is selected).

- 📦 `logDir` is now a system setting (prep for `PhotoStructure for Servers`)

- 📦 on Windows, `PowerShell` is used rather than `attrib` to detect if a file
  is hidden. This turns out to be up to 10x faster, and as we do this for every
  folder, it can speed syncs up substantially.

- 📦 Validation of raw images takes between 3 and 30 seconds per file. The
  library setting `validateRawImages` allows this to be skipped if you don't
  care to check raw images during library import.

- 🐛 Recompiled `sqlite` on macOS as a 64-bit binary, which removes the
  ["PhotoStructure is not optimized for your Mac and needs to be updated"
  dialog](https://support.apple.com/en-us/HT208436). See #154.

- 🐛 When `web` encounters a show-stopper issue (like when the library hard
  drive gets unmounted unexpectedly), it can now tell the `main` process to shut
  PhotoStructure down (rather than just restarting endlessly).

- 🐛 On large tag gallery pages, lazy loading would sometimes load batches out
  of order or more than once. Now, they don't duplicate themselves! And they
  maintain order! That was an ugly bug, sorry about that. See #121.

#### v0.4.0

**Released 2019-05-07**

- ✨ **Open item in folder**: When browsing on the computer that is running
  PhotoStructure, you may now click the photo or video icon by a pathname in the
  asset info view, and the parent directory will be opened in the file explorer,
  with the current file selected. This lets you subsequently edit the file in
  other external apps.

- ✨ WVGA was added as a smaller `maxPreviewResolution` for users only serving
  low resolution browsers.

- 🐛 Settings were rewritten unnecessarily due to a version parsing bug.

- 🐛 If the library directory goes away while PhotoStructure is running (for
  example, when the volume is unmounted or the NAS is shut down), the main
  process will shut down. Before this version, PhotoStructure's `main` process
  would try to restart the web process indefinitely.

- 🐛 Error reporting throttles across processes and services now. Note that
  error reporting can be disabled in the system settings.

#### v0.3.8

**Released 2019-05-02**

- ✨ All asset file originals are now directly downloadable via the asset info
  panel

- ✨ **Metadata sidecar support**:

  - `.XMP`, `.EXIF`, `.EXV`, and `.MIE` file types are supported
  - If a sidecar is found, the metadata in the sidecar overlays the metadata in
    the source file.
  - Sidecars are copied to your library along with your original files (if
    automatic library organization is enabled)

- ✨ During installation, you can now choose "scan everything", "scan my
  pictures directory", or "scan this custom folder."

- 📦 Updates are only checked for once a day (rather than on every launch, and N
  minutes afterwards).

- 📦 Upgraded to Electron 5/node 12, which added `Dirent` support. Large
  directories will be scanned much faster thanks to this.

- 🐛 Changing settings now gracefully restarts sync processes.

- ✨ Some smartphone RAW images have slightly different exposure settings than
  their JPG counterpart. PhotoStructure now handles these "features" properly,
  and will merge the image pairs.

#### v0.3.7

**Released 2019-04-27**

- 🐛 Only support VLC `v3.0.x`, as `v2.x` doesn't support our transcoding
  options, and `v4.0.0-dev` has bugs with window handling on Windows.

- 🐛 PowerShell parsing is now more robust. Some Windows beta testers had failed
  health checks due to missing filesystem volumes.

- 🐛 Large image directories with missing metadata confused the tag inference
  engine. Tag inference now only looks at the nearest N siblings.

- 🐛 Some people found that update notification dialogs could be hidden on
  Windows. Once an update has been downloaded and is ready to apply, the system
  tray now also provides a way to update and restart.

- 📦 Several more "ignorable" directory patterns were added, including "smart
  previews."

- 📦 `psnet` URIs have case-normalized hostnames

- 📦 DB SHAs were reduced from 224 to 192 bits to reduce index memory consumption

#### v0.3.4

**Released 2019-04-20**

- 🐛 Force VLC to ignore existing system configuration to prevent terminal
  flashes. See
  [#126](https://gitlab.com/photostructure/photostructure/issues/126).

#### v0.3.3

**Released 2019-04-19**

🥂 Welcome, second wave of beta users! ✨

- 🐛 "Only examine my Pictures folder" works (again). See
  [#118](https://gitlab.com/photostructure/photostructure/issues/118).

- 📦 All subdirectories in an iPhoto library are skipped _except_ for `Masters`. See [#119](https://gitlab.com/photostructure/photostructure/issues/119).

- 🐛 Stream UX avoids video controls. See
  [#57](https://gitlab.com/photostructure/photostructure/issues/57).

#### v0.3.0

**Released 2019-04-15 11:24:47**

- ✨ Page titles (only visible on browsers) now reflect the page content
- ✨ added another timezone/date parsing heuristic for videos. See
  [#29](https://gitlab.com/photostructure/photostructure/issues/29)
- ✨ library asset subdirectory timestamp is now configurable via
  the `assetSubdirectoryDatestampFormat` setting.
- ✨ PID management now supports indefinitely-old processes (which was needed
  for web and sync). As long as the parent process id is alive, the process is
  allowed to continue.
- ✨ Common music directories (which may contain album art and music videos) are
  now automatically excluded from libraries.
- ✨ Processes watch their memory consumption now, and restart automatically if
  they exceed the `maxMemoryMb` setting, which defaults to 1 GB. See
  [#115](https://gitlab.com/photostructure/photostructure/issues/115).
- ✨ Service shutdown hung for long-lived services while it waited for all
  logfiles to be possibly compressed. This is now done during file rotation.
- ✨ Tag galleries support browsers that don't comply with the Intersection API,
  like Safari on older iOS version, by adding a "Load more..." button.
- 📦 Add support for make/model extraction from new flagship smartphones
- 📦 support spawning `ceil` sync-file processes, which should allow for more
  CPU saturation during sync.

#### v0.2.17

**Released 2019-03-26 10am**

- 🐛 CPU scheduling should match maxCpuPercent closer now (the prior formula
  underscheduled work)
- ✨ Flaky filesystems (like NAS over noisy LAN or CDROMs) are retried and then
  children are skipped if they can't be scanned. See the new
  `statTimeoutSeconds` setting.
- 📦 Settings I/O was updated with more help in the intro.

#### v0.2.16

**Released 2019-03-25**

- 🐛 Fix metadata date parsing error from Luxon

#### v0.2.15

**Released 2019-03-24**

- ✨ CPU utilization had been by "max CPUs," but that proved difficult to
  explain. The new `maxCpuPercent` setting is a "CPU utilization goal" that
  PhotoStructure will attempt to not exceed.
- 📦 Rebuilt and hand-validated new CpuUsage.
- 📦 All dependencies are scanned for vulnerabilities after updates

#### v0.2.12-alpha, v0.2.14

**Released 2019-03-21**

- 🐛 Error handling doesn't crash subprocesses
- 📦 Heap allocation errors with Electron 4. Back to Electron 3.

#### v0.2.11-alpha

**Released 2019-03-20**

- 🐛 Fix [Windows PowerShell
  parsing](https://gitlab.com/mceachen/photostructure/issues/88)

#### v0.2.10-alpha

**Released 2019-03-19**

- 🐛 Fix [Ubuntu upgrade results in 2 tray
  icons](https://gitlab.com/mceachen/photostructure/issues/74)
- 🐛 Default log level is now `error`, so logfiles don't bother people:
  [#74](https://gitlab.com/mceachen/photostructure/issues/74)
- 🐛 All files use ExpressJS's `sendFile` now, which sets etags correctly and
  handles chunked encoding. This should fix
  [#36](https://gitlab.com/mceachen/photostructure/issues/36)
- 📦 New sharp and Electron 4. We'll see how that goes.

#### v0.2.9-alpha

**Released 2019-03-15**

- ✨ Mac's TextEdit defaults to saving text files with smartquotes, which
  corrupts the `settings.toml` files. PhotoStructure straightens out quotes for
  you.
- 🐛 Volumes weren't being marked as "complete" properly.
- 🐛 `maxProcs` ignored values greater than 1.
- ✨ External tasks on Windows were migrated from using `wmic` to using
  long-lived, batch-cluster-managed `PowerShell`.
- ✨ Directory scanning doesn't stat every file anymore. (It had been done
  before to update the progress bar, but it made scanning expensive, especially
  to NASes). See [#80](https://gitlab.com/mceachen/photostructure/issues/80).

#### v0.2.8-alpha

**Released 2019-03-09**

- ✨ all processes spawned by PhotoStructure are tracked by pidfiles now, which
  lets cleanup happen both while PhotoStructure is running, as well as on
  launch, to clean up from prior runs.
- 🐛 rebuilt file import timeout calculations, which incorrectly prevented some
  larger raw image and video files from being imported.

#### v0.2.7-alpha

**Released 2019-03-01**

- ✨ added PullProgressObserver to video and raw image transcode ops
- ✨ long operations (like file copies, SHA, and video transcoding) now show up
  in progress reports.
- ✨ only 1 video transcode will happen concurrently (as ffmpeg and vlc are
  already multithreaded). If other CPUs are available, they will import pending
  images.

#### v0.2.6-alpha

**Released 2019-02-24**

setting. Video streaming in the UI now autoplays instantly.

- ✨ added support for a number of new image and video file types.
- ✨ work planner supports prioritized on-idle workers, which means file
  scanning can happen while asset importing happens, simultaneously.
- 🐛 "stuck" detection was problematic. Removed for now.
- ✨ files and folders can be dragged onto the PhotoStructure icon, or on Mac,
  onto the menu bar icon, and the contents will be imported.

#### v0.2.0-alpha

**Released 2019-02-13**

- 💔 **Users must manually install VLC.** See
  <https://support.photostructure.com/vlc-installation/>

- 🐛 On launch, if the prior library is not available, ask the user what to do
  (quit, reset, try again). Previously launching would just quietly exit, which
  was less than helpful.
- 🐛 Support library settings POST after library path is set
- ✨ Errors from child processes are now propagated to the desktop app for display to
  the user.
- ✨ New system setting to allow users to opt out of error reporting (see `reportErrors`).
- ✨ New system settings control sync behavior (see `startPaused` and `volumeResyncPeriodHours`)
- ✨ New library settings to control file validation (see `validateImages` and
  `validateVideos`). Validation slows synchronization, and video validation is
  especially expensive. Given that videos can still play even with bitrot, the
  default for videos is to do minimal validation (intact metadata and the
  ability to extract a frame from the beginning of the video).
- ✨ New library settings to control which images and videos are eligible for
  library import (see `minImageDimension`, `minVideoDimension`,
  `minFileSizeBytes`, and `maxFileSizeBytes`). For min dimension settings,
  Images and videos must have both dimensions be greater than or equal to these
  values. They default to 480 for images and 240 for videos.
- ✨ New library settings to control what previews are created (see
  `maxPreviewResolution`).
- ✨ New system settings to manage when PhotoStructure checks for upgrades (see
  `updateOnLaunch` and `updateCheckMinutes`, which work in concert with
  `updateChannel`).
- ✨ New system settings to manage how many CPUs PhotoStructure is allowed to
  use (see `maxCpus`).
- ✨ PhotoStructure work scheduling was restructured, which should result in
  faster Asset processing, and should fix "stuck" synchronization.

#### v0.1.15

**Released 2019-01-26 20:30**

- 🐛 Library settings are properly read on re-launch
- 🐛 Fixed empty terminal shell spawning on windows

#### v0.1.14

**Released 2019-01-26 14:00**

- 🐛 Reverted back to Electron 3, as the system tray under linux was broken in
  Electron 4.

- 🐛 Fixed nslookup error in remote mountpoint name resolutions

#### v0.1.12

**Released 2019-01-26 12:02**

- ✨ Support for persisted system and library settings. Any external edits must be
  done while PhotoStructure is shut down.

  System settings paths:

  - Linux: `~/.config/PhotoStructure/settings.toml`
  - Mac: `~/Library/Application Support/PhotoStructure/settings.toml`
  - Windows: `%USERPROFILE%\AppData\Roaming\PhotoStructure\settings.toml`

  Library settings path: `$YOUR_LIBRARY/.photostructure/settings.toml`

- Settings are saved in [TOML](https://github.com/toml-lang/toml), which both
  supports comments, and was designed for humans to both read and write.

- PhotoStructure's updater now supports release channels (`latest`, or `beta`)
  via your system settings.

- A number of other system settings are exposed as well, including resolution of
  [#53](https://gitlab.com/mceachen/photostructure/issues/53).

#### v0.1.11

**Released 2019-01-15 21:01**

- Fixed [ABI issue](https://github.com/lovell/sharp/issues/1522) caused by
  Electron 4

#### v0.1.10

**Released 2019-01-15 19:00**

- Rewrote volume detection to be async on Mac and Linux. This should help
  prevent volumes "disappearing" and causing PhotoStructure to pause
  synchronization of large external volumes.
- Updated to Electron 4.0
- Linux volumes include GVFS mounts, like SMB and AFS mounts via the Gnome Files
  app
- Breadcrumbs are included in Asset views
- Hostname resolution supports more routers now
- Reworked mountpoint scanning to use `diskutil`, `gio`, or `findmnt --poll`
  (whatever is available), which gives us real-time mountpoint updates on Mac
  and Linux. This _should_ resolve the error where mountpoints can temporarily
  disappear (according to `df`), which cancels synchronization on larger
  volumes.

#### v0.1.8

**Released 2018-12-19**

- First external beta test on Mac OS 10.13
- Concurrent transcoding is serialized
- `df` information is shared across PhotoStructure processes, which should lower
  system resource load
- Phone selfies were being rejected by the image resolution filter. That
  criteria has been dropped to allow these ~1MP images.
- Progress per volume is isolated by separate message queues now.

#### v0.1.5

**Released 2018-12-08**

- Sync process can be paused and resumed via the tray/menu bar icon
- videos are validated by ffmpeg before importing

#### v0.1.4

**Released 2018-12-07**

- Automatic update support for Mac and Windows
- Automatic on-the-fly video transcoding for non-mp4 videos
- Additional timezone offset heuristics are applied when missing from metadata
  to prevent reverting to UTC
- Advisory locking surrounding asset importing ensures consistent behavior on
  multi-cpu hosts
- Special characters in metadata fields are now supported

#### v0.0.46 - 50

Performance improvements:

- Full-screen assets include the original image as a srcset value. This improves
  rendering quality for smaller assets, and allows for zooming to 1:1 with the
  original.
- UHD 5K is now the largest resized preview value.
- Preview sizes are skipped if they are not > 2x smaller than other sizes. This
  allows for more image sizes to capture different aspect ratio assets, but
  doesn't increase the size of the PhotoStructure previews library.
- PhotoStructure library assets are always scanned first on startup.
- All thumbnails are lazy-loaded, which reduces load on the webserver when
  libraries are large.
- Large lists of thumbnails are loaded lazily now, as they scroll into view.
- Large file imports deliver async progress to the sync service (to answer the
  question "why is it stuck"? "Oh, it's a 5GB GoPro video, that I will most
  definitely watch all of and warrant it taking up bajujibites of my HD." )

Bug fixes:

- Vertical videos are rotated as expected
- Movies from old digital cameras are included by PhotoStructure libraries now
- Video streams now work across platforms and browsers (when the OS has the
  correct codec)
- Thumbnails for any given asset is generated from a single asset file version.
- Internal RPC was rebuilt to support retries and error backpropogation

#### v0.0.45

**Released 2018-09-07**

- Added support for fullscreen video streaming
- Added web health check
- Fixed sometimes-missing video thumbnails

#### v0.0.41 - 44

**Released 2018-09-05**

- Dropped max filesize filter from 3gb to 1gb, given the asset processor timeout
  is currently static, and large videos were making the asset importer hang
- Fixed copy-file-to-library on mac, which was locking (?) the files. We
  force-unlock the .wip immediately after copying now (which should be fine,
  given that it's our copy of the file, so we aren't arbitrarily unlocking
  files).
- `psvol`, `psnet`, and `pslib` URI protocols now handle root directories

#### v0.0.20 - 40

- Work on auto-updating

#### v0.0.19

**Released 2018-08-27**

- Auto-update available through the Tray
- Only half the system CPUs will be spawned for `sync-file` to reduce memory
  footprint
- Directory statistics are stored by URI, which is stable regardless of the
  mountpoint or drive letter, rather than path.
- Internal volume information is gathered with more robust stdout streaming, and
  retries and timeouts were added, all of which should make it more reliable.
- Upgrade to Electron 3.0 (comes with new node 10.2)
- ExifTool warnings don't reject tag promises anymore
- CapturedAt interpolation now takes into account the fellow siblings that also
  don't have metadata in order to maintain existing sort order
