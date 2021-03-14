
This is a detailed list of changes per version.

- Releases sometimes have separate posts that describe new features, like for
  [version 0.6](/about/v-0-6/), [version 0.8](/about/v-0-8/), and [version
  0.9](/about/v-0-9/)).

- Visit [**what's next**](/about/whats-next/) to get a sneak peak into what
  we're going to be working on next.

## Please note

- **Stable, released versions are recommended.**

- See [Alpha, beta, stable, and latest; What should you
  use?](https://forum.photostructure.com/t/alpha-beta-stable-and-latest-what-should-you-use/274)
  for more information.

- "Pre-release" builds (those that end with `alpha` or `beta`) have not been
  thoroughly tested, and may not even launch.

- Only run `alpha` or `beta` builds if you have [recent
  backups](/faq/how-do-i-safely-store-files/).

- If you update to an alpha or beta build and you want to downgrade to a prior
  version, know that older versions of PhotoStructure may not be able to open
  libraries created by newer versions of PhotoStructure. You will probably need
  to [restore your library from a database
  backup](/faq/restore-db-from-backup/).

<a id="v1.0.0"></a>

## v1.0.0-alpha.0

**to be released**

## Please note

- 💔 PhotoStructure for Desktops on Linux now requires at least Ubuntu 20.04.
  **If you're on Ubuntu 18.04 or earlier, please switch to the [server
  edition](/server/photostructure-for-node/#ubuntu-install)**.

  By dropping support for 18.04, which seems to be rarely used (according to
  Twitter and Reddit polls), we can upgrade to newer versions of Electron and
  Sharp, picking up several security and performance improvements.

## New curators

Note that a library rebuild will be kicked off automatically by this new
version, but you get a bunch of new goodies:

- ✨ Directory hierarchy tags: you can now browse by filesystem! These tags are
  integrated in the asset info panel as well.

- ✨ Google Photos albums from Takeouts are now detected and albums are imported
  as tags.

- ✨ Google Photos JSON sidecars from Takeouts may contain people and pets. These
  are now detected and imported as tags.

- ✨ Adobe Lightroom, DigiKam, Picasa, and Google Photos users, rejoice:
  PhotoStructure now extracts face tags from these apps and adds them to the new
  "Who" root tag.

- ✨ If you're feeling adventurous, set `PS_TAG_NAMES_FORMATTER=family/given`.
  This enables PhotoStructure's new name parser and lets you navigate by
  `Who/Last/First`. Details about this new name parser will be added to the
  website soon.

## More storage flexibility

✨ Want to run your PhotoStructure library from your SSD, but copy your originals
to a different folder hierarchy?

The new `originalsDir` [system
setting](/getting-started/advanced-settings/#system-settings) specifies the
directory to store original images when `copyAssetsToLibrary` is enabled.
Absolute paths are supported. Relative paths are evaluated from your
`libraryPath`. This setting defaults to ".", which is the same as your
PhotoStructure library directory.

**This setting needs to be set appropriately on different computers (it won't be
set automatically!)**

If you open your PhotoStructure library on a different computer, and that
computer doesn't have access to the volume with your originals, full-screen zoom
won't work, and non-transcoded videos will not play.

If you have a large library and want to use an SSD, we recommend you set your
libraryPath to your SSD, and use this setting to store your originals on a
larger volume (rather than using the previous `previewsDir` setting which
fragmented your library).

## Improved HEIC support

Due to patent and licensing issues, PhotoStructure does not come with support
for `.heic`. Prior versions of PhotoStructure required complicated recompilation
steps to support HEIC, and only to the PhotoStructure for Node edition. This
version brings HEIC support to all editions, and is [substantially easier to
install](/getting-started/heif-support/).

## Improved image hashing

- Prior image hashes were made rotation-invariant by normalizing orientation to
  the quadrant with the least magnitude. Unfortunately, cameras producing
  JPEG+RAW pairs using "computational imagery" could change the final image
  regional brightness to change this quadrant, which results in a false-negative
  match.

  We tried several other algorithms to find a stable orientation (like
  most-variant-quadrant) but then realized it took less than a millisecond to
  "brute force" match by checking hashes against all rotation variants.

  The image hash stored in the database is now oriented based on the rastered
  image orientation, ignoring metadata rotation values. This means we don't have
  to read EXIF tags from the file or sidecars in order to produce the image
  hash.

- Color image matching is now controlled by the new `minImageCorrPct`,
  `minColorCorrPct`, and `minMeanCorrPct` library settings. More details are in
  those settings' descriptions.

- When greyscale images are compared, they now require higher image correlation
  (customized by the new `minImageGreyscaleCorrPct` library setting).

- Rotation normalization now uses this new rotation-invariant image hash
  implementation. Rotations used to take several seconds due to rotation
  normalization, and is now essentially instantaneous.

## Improvements and bugfixes

- 🐛/👻 Seeing ghosts? The `useEmbeddedPreviews` boolean library setting has
  been replaced with the new `embeddedPreviews` `string[]` setting to fix
  [incorrect ghostly rendering of some iPhone
  photos](https://forum.photostructure.com/t/i-see-ghosts/41). The same
  conversion (from boolean to string[]) was also done to `useEmbeddedThumbnails`
  => `embeddedThumbnails`.

- 💔/📦 The `networking` settings group was moved from library settings to system
  settings. This affects `localhost`, `httpPort`, `exposeNetworkWithoutAuth`,
  and `rpcPort`. If you've configured these via environment variables, you don't
  need to do anything.
- ✨ PhotoStructure now caches `readdir()` results. Several beta testers have
  used software that dumped their entire 50k+ photo library into a single
  directory, which doesn't play nicely over a remote filesystem.

  By caching `readdir()` results (see the `readdirCacheSeconds` setting),
  PhotoStructure's sibling inference and file scanning codepaths should be able
  to not get "stuck" on these sorts of directories anymore.

- ✨ For PhotoStructure on Desktops users on macOS or Windows, you can now
  enable `Open at login` via the `PhotoStructure` or `File` menu bar.

- ✨ PhotoStructure sync processes can now be canceled mid-flight by sending the
  process a `SIGUSR1` signal. This is handy for users that want to run [manual
  sync jobs](/server/tools/#how-do-i-sync-folders-manually).

- ✨ The "best" asset file variant is now configurable via a new
  `variantSortCriteria` library setting. [See the forum post for more
  information](https://forum.photostructure.com/t/does-the-bold-file-name-in-info-panel-signify-anything/156/7).

- ✨ FFmpeg settings are now configurable via the new `ffmpegTranscodeArgs`
  system setting, in case you want to [use hardware
  accelleration](https://forum.photostructure.com/t/hardware-accelerated-encoding-transcoding/166).

- ✨ Normally PhotoStructure ignores any volumes that are "unhealthy" (as
  reported by the OS). This prevents PhotoStructure from doing I/O against that
  volume which can cause system instability. A new `ignoreUnhealthyVolumes`
  setting, which defaults to `true`, lets you override this behavior.

- ✨/🐛 Image validation types [can now be
  configured](https://forum.photostructure.com/t/missing-file-quantization-tables-are-too-coarse-for-baseline-jpeg/352/2?u=mrm)
  via the new `validationErrorBlocklist` library setting.

- ✨/🐛 PowerShell's startup arguments are now configurable via `powerShellArgs`
  which [addresses this
  issue](https://forum.photostructure.com/t/eliminate-powershell-profile-and-execution-policy-related-errors/184).

- ✨/🐛 Sibling files that are used for tag inference must now either share a
  stat time within a day of the target, or have a parsable-to-timestamp filename
  whose sibling also parses to an adjacent day (this helps prevents
  PhotoStructure from looking at spurious siblings).

- ✨/🐛 Square thumbnail cropping is now only performed once (rather than scaling
  all sizes in parallel). Prior versions of PhotoStructure could generate
  different square thumbnails for different sizes, as the crop algorithm would
  behave differently at different resolutions.

- ✨/🐛 Prior versions of PhotoStructure would decide if a file needed to be
  transcoded by examining the MIMEtype of the video.

  This works OK for several formats, but for video container types that can
  store several different codecs, MIMEtype is not sufficiently comprehensive,
  and for several users, resulted in [videos that played audio by not
  video](https://forum.photostructure.com/t/iphone-videos-play-with-sound-but-no-video/39).

  Instead, PhotoStructure now looks at the container type, _and the audio and
  video codecs used_, to see if the video will play correctly on most evergreen
  desktop and mobile browsers.

- ✨/🐛 Some users reported [incorrect colors in RAW
  images](https://forum.photostructure.com/t/wrong-colors-in-your-raw-images/31).
  To solve this, PhotoStructure now uses `libraw` instead of `dcraw`. `libraw`
  is actively developed, handles many more raw image types, and is faster as
  well.

- ✨/🐛 Try to prevent "tofu" (missing glyphs rendered as empty squares) by
  including latin-ext font glyphs as well as several common non-latin system
  fonts.

- ✨/🐛 `When` tags now use the new `_displayName` field to render the `i18n`'ed
  display version of a month. This avoids having different tag names for the
  same month because the system locale changed between runs.

- 🐛 "Open file in folder" on Windows could fail if the path had whitespace.

- 🐛 PhotoStructure could fail to launch if `readdir` failed for any root
  directories of volumes.

- 🐛 Some docker containers befuddled PhotoStructure's `isDocker()` detection.
  This is now forced to true within the `Dockerfile` by setting `PS_IS_DOCKER`.

- 🐛 Network file shares mounted via IP address versus zeroconf may not have
  properly resolved URNs, which may result in duplicate URIs generated for the
  same device. If you find this duplication in your asset info panel, please
  contact support@photostructure.com and we can help get things sorted.

- 🐛 Cache directory cleanup now gracefully handles filesystems whose caches
  aren't strictly updated, which could result in directories that weren't
  cleaned up properly.

- 🐛 JPEG+RAW image pairs can have _different GPS locations_! This is due to the
  GPS location being acquired by different sources (cellular vs A-GPS vs WiFi vs
  actual GPS satellite telemetry). Prior deduping would mark image pairs that
  were not strictly equal as different images. Current deduping will consider
  the location to be equivalent if the distance between the two GPS locations
  are less than `gpsErrorMeters`, which defaults to 500 meters.

- 🐛 Fixed ["internal error: Error: no pending
  currentTask"](https://forum.photostructure.com/t/crash-from-internal-error-no-pending-currenttask/106)
  The issue is from `sync-file` reporting health status from a periodic timer,
  but because the parent didn't ask, it flips out. The fix makes the daemon get
  quietly recycled when health checks fail.

- 🐛 [Exotic timezones are now handled
  properly](https://forum.photostructure.com/t/incorrect-captured-at-detection/305/2?u=mrm).

- 📦 PhotoStructure for Desktops on macOS now detects and fails if it is being
  launched from the DMG (instead of having been installed into the
  `Applications` directory).

- 📦 Double-clicking the system tray icon now opens the home page.

- 📦 Added new `useLibraryPathsToInferDates` (which defaults to `false`) to
  avoid propagating previously-incorrect date parsing (due to the asset having
  been placed in the incorrect timestamped folder).

- 📦 Added `useStatToInferDates` setting (which defaults to `true`). Setting
  this to `false` will omit assets whose captured-at time cannot be extracted
  except via the filesystem's `stat` record (which is not a reliable source for
  captured-at, as file transfers and backups frequently don't retain these
  values correctly).

- 📦 Added `fuzzyYearParsing` (which defaults to `false`). When enabled,
  PhotoStructure will use directories starting with a number that looks
  year-like (four digits, 1826-2020) to infer the captured-at time, if all other
  date parsers have failed. Note that setting this to true "forces" the
  `fuzzyDateParsing` setting to be true as well.

  PhotoStructure first looks for metadata with a date, then looks for an
  ISO-compliant YMD timestamp in the filename or path, and then, if
  `fuzzyDateParsing` or this setting is enabled, a YMD or YM datestamp, and then
  finally, if this setting is enabled, it looks for a directory that begins with
  a number that is between 1826-2020.

- 📦 Added `minValidYear` (which defaults to 1826, the [first year a photograph
  was captured](https://en.wikipedia.org/wiki/History_of_photography)). If you
  have paintings or other imagery from before 1826, you'll want to make this
  value less than the earliest image in your library.

- 📦 Filenames with YYYY_MM_dd HH_mm_ss datestamps can now be parsed and used
  for the captured-at time (used only if metadata is missing).

- 📦 `.thm` files are no longer looked at as import candidates.

- 📦/🛡️ PhotoStructure spawns a number of processes (including `exiftool` and
  `ffmpeg`), and passes through inherited environment variables, mostly to
  ensure locale and TZ settings are correct. To prevent environment values that
  contain sensitive information, like API access tokens, from either being
  logged by PhotoStructure, or from being accessed by external tools, all
  environment variables whose key matches the new `sensitiveEnvRegExp` setting
  will be removed. This defaults to keys that contain the strings `SECRET`,
  `KEY`, `PASSWORD`, or `PASSWD` (and aren't a PhotoStructure environment
  variable).

  Prior versions only logged environment variables specific to PhotoStructure
  (like `PS_LIBRARY_PATH` and `PS_LOG_LEVEL`), so no prior disclosure (except to
  spawned `ffmpeg` and `vlc` processes) should have occurred.

  (**Note to beta users: You may want to consider rotating any keys held in
  your env, just to be safe**.)

- 📦/🐛 Orphaned tags are now properly vacuumed from the library (prior SQL could
  quietly fail).

- 📦/🐛 Tag counting temporary tables are cleaned up properly now.

- 📦/🐛 The `HistoryWhen` tag is no longer considered a possible valid value for
  an asset's "captured-at" time (as it pertains only to when the `History` tag
  was modified).

- 📦 All health checks can now be individually disabled. This allows disks to
  spin down when idle, but also means PhotoStructure may not be able to detect
  and automatically recover from network, file system, and internal glitches. See
  `healthCheckDb`, `healthCheckExiftool`, `healthCheckFreeSpace`,
  `healthCheckLibraryIsWritable`, and `healthCheckVolumes`.

- 📦 PhotoStructure for Desktops now detects some common initial system setup
  issues, and now asks the user if it can open a browser window to the
  appropriate (hopefully helpful) article on PhotoStructure.com.

- 📦 For PhotoStructure on Desktops users on Windows or Linux, you can now pick
  to enable or disable the "tap the <key>alt</key> key to toggle menu bar
  visibility" via the `View` menu bar.

- 📦 To help expedite shutdowns, PhotoStructure now skips maintenance tasks when
  the process is ending.

- 📦 Zoom on thumbnail hover was disabled (to accommodate motion-sensitive
  users). If you miss this feature, please [post a feature request to the
  forum](https://forum.photostructure.com/c/feature-requests/7) to add this as a
  UI preference (much like thumbnail size).

- 📦 `logcat` accepts file and directory paths now. Directories are recursively
  searched for ".log" and ".log.gz" files.

- 📦 The command run by "open file in folder" is now customizable to support
  XFCE and other window managers. See `openFileInFolderUsesFileUri` and
  `openFileInFolderCommand`.

## Prior release notes

- [**Release notes from 2020**](/about/2020-release-notes)

- [**Release notes from 2019**](/about/2019-release-notes)
