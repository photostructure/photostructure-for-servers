
This is a detailed list of changes in each version.

- Major releases have posts summarizing bigger changes. See [the posts tagged with "release notes"](/tags/release-notes/).

- New releases, starting in 2023, use "calendar versioning," or [CalVer](https://calver.org/), using scheme `YYYY.MM.MINOR`.

- **Stable, released versions are recommended.** [See the forum post for details about alpha, beta, and stable releases.](https://forum.photostructure.com/t/alpha-beta-stable-and-latest-what-should-you-use/274)

- "Pre-release" builds (those that include `alpha` or `beta`) have not been thoroughly tested, and may not even launch.

- Only run `alpha` or `beta` builds if you have [recent backups](/faq/how-do-i-safely-store-files/).

- If you update to an alpha or beta build and you want to downgrade to a prior version, know that older versions of PhotoStructure may not be able to open libraries created by newer versions of PhotoStructure. You will probably need to [restore your library from a database backup](/faq/restore-db-from-backup/).

<!-- TODO: -->
<!-- - ✨ Logs are now viewable in the UI -->
<!-- - 🐛 [Tag reparenting doesn't seem to work properly on rebuilds](https://forum.photostructure.com/t/who-tags-are-incorrectly-excluded-from-keywords/676/6?u=mrm). -->

<!-- - 🐛 Sync resume (after pause) on mac via the menubar (not the main window nav button) doesn't seem to support "resume" properly -->

<!-- fix "tag context" for "next previous" context. I'd always done a search, clicked a thumb, and then clicked esc to go back to the search results. But...  if you click a thumb from a search,  and then click "next" or "previous", it ignores that you can from a search, and does the chronological next asset, which is very confusing/irritating. -->

## v2023.8.0-prealpha.9

**Released 2023 August 28**

- 📦 v2023.8.0-prealpha.9 adds a missing dependency on `type-detect`, and updates several other third party libraries.

## v2023.8.0-prealpha.8 ("nighthawk")

**Released 2023 August 28**

Note that prior prealpha builds were `YY.MM.MINOR`, and after a discussion on [Discord](https://discord.com/channels/818905168107012097/818907922767544340/1145044739268296744), we're switching to `YYYY.MM.MINOR` to make it clearer that the first number is a year.


- ✨/🐛 Deduplication improvements: see new `allowFuzzyDateImageHashMatches` setting. [More details are in the forum](https://forum.photostructure.com/t/deduplicate-shenanigans/1732/14?u=mrm). Thanks for your help, @nuk!

- 🐛 Docker setup on new instances was broken due to (several) health check bugs. This caused a redirect loop from the welcome page to the health check page ([see discussion](https://discord.com/channels/818905168107012097/1139058626976288798)).

- 🐛 Improvements to avoid overscheduling and timeouts:

  - Health checks are now processed with a bounded concurrency queue, rather than all 35 checks running in parallel, which could cause [spurious health check failures](https://discord.com/channels/818905168107012097/1139270057906679818).
  - Parts of `sync`'s file processing pipeline had used bounded concurrency queues in an effort to expedite completion. Unfortunately, this results in overscheduling, especially if assets have sidecars. The processing pipeline has been changed to always use serial processing to avoid this overscheduling, and rather than defaulting `maxConcurrentImports` to 50% of maxCpus, the new default is 100% of maxCpus. This should avoid [overscheduling timeouts like this](https://discord.com/channels/818905168107012097/1138942378938470450).

- 🐛 Directory iteration had a step that examined sidecar eligibility in a tight loop, synchronously, which could cause spurious external timeouts when processing directories with many (1k+) sidecar files. Sidecars are now processed asynchronously in timed chunks (just like non-sidecars) to avoid this situation.

- 🐛 `sync` memory consumption could grow to > 1GB on high CPU hosts. Memory allocation and retention was profiled and several hotspots were remediated, allowing for better GC of child process, weak, and lazy references, and `sync` is back down to ~50MB, steady state.

- 📦 The base image for PhotoStructure for Docker is now [node-20-bookworm-slim](https://github.com/nodejs/docker-node/blob/1a4f3d2d0c914b4468ba9675cedf70a2f4f0f82d/20/bookworm-slim/Dockerfile).

  I initially based PhotoStructure for Docker off of [Alpine](https://www.alpinelinux.org/) because the Alpine base image size (181MB) was smaller than the Debian image base (245MB).

  After installing all of PhotoStructure's prerequisite libraries and tooling, though, the base tools images are quite comparable: Alpine is 619MB and Debian is 787MB.

  Given this lack of substantial size benefit, Alpine suddenly looks less appealing:

  - Supporting Alpine is Yet Another Platform that requires special codepaths in PhotoStructure and requires the test suite to be run in
  - Several issues (including buggy RAW DNG image decoding) are only reproducible within Alpine, so just by moving to Debian, we "fix" the bugs
  - The `ffmpeg` package in Debian supports several more codecs.

- 📦 The library test suite is now runnable within docker. Test runs within docker in previous versions were limited to the core test suite.

## v23.8.0-prealpha.7

**Released 2023 August 11**

- 🐛 Fixed Windows volume status parsing (thanks for the assist, @mackid1993!)

- 📦 Added log level and directory to the about page

- 📦 Fixed font weight rendering and upgraded Roboto and Roboto Mono to latest versions thanks to [Google Fonts Helper](https://gwfh.mranftl.com/fonts)

## v23.8.0-prealpha.6

**Released 2023 August 10**

- 🐛 Remove spurious "missing volume UUID for `/`" on docker ([details](https://discord.com/channels/818905168107012097/1138934056587886672/threads/1139071622100303923))

- 🐛 Attempt to fix FK error in Tag ([details](https://discord.com/channels/818905168107012097/1139180240845942876))

  - disable Tag instance caching
  - assign NULL values from the db back to the models

- 📦 Downgrade levels for a heap of `.warn` and `.info` logs

## v23.8.0-prealpha.2-5

**Released 2023 August 9**

- 🐛 Support `$PUID` and `$PGID` values of 1000 (which collides with the docker image `node` user and group) ([details](https://discord.com/channels/818905168107012097/1139006067087527936))

- 🐛 Upgrade Dockerfile to Node.js v20

- 🐛 Disable `proc-not-superuser` health check on Windows by default: everyone always runs as an admin user.

- 🐛 Fix github actions to properly tag `:prealpha` builds

<a id="v2.1.0-alpha.8"></a>
<a id="23.5.0-prealpha.1"></a>
<a id="23.6.0-prealpha.1"></a>
<a id="23.7.0-prealpha.1"></a>

## v23.8.0-prealpha.1

**Released 2023 August 8**

_(This version's contents had previously been listed as_ `v2.1.0-alpha.8` _, but we're switching to [CalVer](https://calver.org/), using scheme_ `YY.MM.MINOR` _.)_

### ✨ **PhotoStructure no longer "fails fast."**

_What's that mean?_

PhotoStructure will try to always stay up and running, even if your library isn't available, or something's amiss, like a misconfiguration or something broken on the system.

If anything prevents your library from being open, PhotoStructure will automatically redirect to a new `/health` page that list several handfuls of health checks to help people diagnose what's amiss, and in some cases, buttons that can attempt to repair what's wrong.

{{< figure src="/img/2023/05/health.png" caption="PhotoStructure's new health check page" >}}

This means people running PhotoStructure for Docker without reading the instructions will be presented with a friendly screen with direct links to the relevant documentation.

This change also meant I could put the `/about` page on a diet--it only holds fairly cheap and cached content now, so it shouldn't disconcertinly hang anymore (prior versions ran several "health checks" that were run synchronously whenever the about page was requested).

This change also means PhotoStructure [stays up even if your library hard drive gets periodically disconnected](https://forum.photostructure.com/t/support-for-often-unplugging-my-ps-library/52).

There are now more than 15 health checks which cover common setup issues, including

- file or directory permission errors
- missing volume UUIDs
- database schema validation
- misspelled or misconfigured settings
- external tool verifications

[Read more about this change on the forum](https://forum.photostructure.com/t/disable-photostructure-from-failing-fast/501).

Note that any (and all!) health checks can be disabled with the new `PS_SKIP_HEALTH_CHECK_IDS` setting.

### ✨ SQLite improvements

- PhotoStructure now automatically figures out the best value for [PS_FORCE_LOCAL_DB_REPLICA](https://forum.photostructure.com/t/whats-ps-force-local-db-replica/837). Previously, we simply defaulted all docker installs to use a local db replica, whose implementation was problematic with prior versions. This determination is also run within a filesystem advisory lock, to prevent concurrent db setup collisions.

- Database backups are now always taken "hot." Prior versions required acquiring a halt-the-world mutex to prevent cold backups from causing SQLite corruption (and prior versions had some codepaths that didn't acquire the lock durably). Prior versions could also miss copying over the `-wal` write-ahead log, which could also cause SQLite corruption.

- The new db health check now validates file integrity, foreign keys, and that the schema comprehensively matches expectations for the current version.

### ✨ PhotoStructure for Desktops improvements

- The main window now preserves placement (even across screens) and dimensions between runs.

- The `View` menu now has links to go back, open the log and sync reports directories, the system `settings.toml`, and the library `settings.toml`

### ✨ PhotoStructure for Servers improvements

- Docker and node editions now have a splash screen to see wth is going on at startup (without having to tail logs). (This page only shows if your library is quite large, your computer is quite slow, or a combination of both).

- If PhotoStructure can't open the current library, instead of crashing, a new "PhotoStructure Status" page will be shown with diagnostics to help debug what went wrong and links to how to fix it. This should be a lot more friendly (especially as a first impression) for most people.

- PhotoStructure's binaries and supporting files were moved from `/ps/app` to `/opt/photostructure`. This move shouldn't impact anyone, and was made to avoid people being confused by mounting anything to `/ps` and hiding the entire installation.

### ✨/🐛/🏗️ Image deduplication improvements

- Dominant color extraction now uses adaptive greyscale prefiltering, iterative k-means clustering, and returns percent coverage per color. **This change required a database migration** (that will be applied automatically) **and a library rebuild** (that will be scheduled automatically). See the new `dominantColorPixels`, `dominantColorKmeansRuns`, `dominantColorMergeThreshold`, and `dominantColorGreyThreshold` settings.

- Prior builds relied on a single (mean) image hash algorithm. This build adds two additional, novel [CIELAB](https://en.wikipedia.org/wiki/CIELAB_color_space)-based approaches (gradient diff and DCT). Having 3 different hashes dramatically helps both [precision and recall](https://en.wikipedia.org/wiki/Precision_and_recall).

- Image hashes now use higher-quality resizing interpolation.

- New settings to control correlation thresholds: `minImageCoeffPct`, `minColorCoeffPct`, `imageHashFuzzyDateDelta`, `imageHashFuzzyDateDelta`, `imageHashRotationDelta`, `imageHashDifferentMimetypesDelta`, and `imageHashGreyscaleDelta`.

- When comparing two files, if either one of the files has an "imprecise" or "fuzzy" captured-at value (if the source is from the filename, inferred or from `Stats`), the image hash is always used, and the captured-at can be different. Disable this behavior by setting `strictDeduping=true`. Prior builds would skip the image hash comparison in some cases. **This change will require libraries to be rebuilt when upgraded to this build**.

### ✨/🐛 Time parsing improvements

- Video files are _notoriously_ hard to get correct captured-at timezone offset values. Videos [regularly encode the `CreateDate` tag in UTC](https://github.com/photostructure/exiftool-vendored.js/issues/113) (even when the file wasn't captured in UTC!). This results in videos from prior versions of PhotoStructure being wrong by several hours. PhotoStructure now tries to "repair" the UTC timezone into the correct timezone by using either GPS metadata or a timezone offset inferrable via the filename. PhotoStructure also now has prioritized tag extraction: see the `capturedAtTags` and new `capturedAtTagsFallback` settings. Note that some Quicktime tags are not reliably stored as UTC, so we look for more reliable tags before resorting to these problematic tags. **If you find a video doesn't have the correct time in your PhotoStructure library, please email us an example.**

- Timezone parsing has been improved to support both IANA and ISO offset formats (both of which have been found in the wild 😠).

- PhotoStructure handles missing timezones and differing timestamp precision more intelligently now: see `minCapturedAtPrecision` and `fuzzyDatePrecisionCoeff` for explanations.

- Google Takeout JSON sidecar timestamps no longer (incorrectly) inherit the current system timezone.

### Other improvements and bugfixes

- ✨ Tag galleries now support both square crops as well as aspect-respecting thumbnails. The toggle is in the upper right corner of all tag galleries.

- ✨ Asset file aggregation is stricter. Previous versions of PhotoStructure attached file variations to existing assets as long as they matched _any_ asset file associated to the asset. PhotoStructure will now aggregate new asset files only if they match all asset file variations. Set the new `assetAggregation` setting to `union` to restore prior behavior.

- ✨ Both [Alpine](https://www.alpinelinux.org/) and [Ubuntu](https://ubuntu.com/download/server) Docker images are now available. There are pros and cons to both images:

  - Alpine images are less than half the size of the Ubuntu-based images
  - Ubuntu's `ffmpeg` package supports (many!) more video codecs
  - Ubuntu has better GPU acceleration support
  - Performance between the two images is roughly equivalent

- ✨ `psnet:` [asset file URIs](/faq/what-is-a-volume/#volume-uuids-save-the-day) now support `sshfs`-mounted partitions

- ✨ A new `transcodeMaxResolution` setting allows transcoded videos to not exceed a specific resolution threshold. [See the forum post for details](/https://forum.photostructure.com/t/specifying-video-transcoding-resolution/1903).

- ✨/🐛 Prior versions on Windows and Raspberry Pi on slow disk could result in invalid file lock timeouts, which could prevent some file types (like large HEIFs) from being imported. This could show up as `EBUSY` or `ENOENT` errors in your sync report or logs.

- ✨/🐛 Some camera models (like the Galaxy S8+) can produce images that have JPEG encoding errors. Prior builds would prevent importing of these images. (Thanks for the example images, [@nighthawk!](https://forum.photostructure.com/u/nighthawk/summary))

  Handling these images required a couple changes:

  1. A new setting, `imageFailOn`, lets you import images that have minor encoding defects by default, but still reject images that have been truncated.

  2. Default values for the image validation patterns, `validationErrorBlocklist` and `validationErrorAllowlist`, now handle more corruption patterns.

- 💔/🐛 The `processPriority` setting no longer supports `AboveNormal`. If your settings used this value, `processPriority` will resort to the default, `Idle`. `AboveNormal` only worked if PhotoStructure was running as root (which it never should do!)

- ✨/📦 The `/site.webmanifest` file is now dynamically generated, and includes a proper `start_url` (so every launch will pick a new seed) and defaults to `display: fullscreen`.

- ✨/📦 [`info` tool](https://phstr.com/go/info) improvements:

  - Image hash comparison information, including all correlations, deltas, and thresholds, are now included for files (which may help tune `imageHash*Delta` settings values).

  - Dominiant colors now include friendly names and percent image coverage.

  - Limit output to only image hash metadata with the new `--image-hash` filter.

  - `pathToLibraryAsset` is now rendered for every file to help debug the `assetPathnameFormat` setting.

  - When given more than one file applies clustering on the entire array and will return the files provided to ARGV, grouped by asset.

  - Several additional switches were added to `info` to help customer support, including `--read-settings`, `--suggested-libraries`, and `--child-env`.

- ✨/🐛 Files with extensions that don't match their mimetype (say, JPEG-encoded images named `image.dng`, which Google Takeouts likes to do) are now imported gracefully.

- ✨/🐛 `settings.toml` and `.psenv` files are now read correctly when BOM-encoded as UTF-8 or UTF16-LE.

- 🐛 [Glob exclusion patterns](https://forum.photostructure.com/t/new-in-v2-1-exclude-files-with-globs/1458) were not being applied correctly on Windows

- 🐛 Newer linux distributions could pull in a version of `heif-convert` that has a buggy filename parser. PhotoStructure invokes this tool in such a way that this bug is avoided.

- 🐛 Prior builds would cache the absence of `heif-convert` until restart, which caused confusion for some users. PhotoStructure will now detect newly-installed `heif-convert` binaries within a minute.

- 🐛 Fixed docker `:alpha`, `:beta`, and `:stable` tagging ([see the simplified example](https://github.com/mceachen/gha-test/blob/cb1a0c76a0be5bbcca6a002d5b41f76fa40031ae/.github/workflows/docker-build.yml#L39))

- 🐛 Rewrote how tools (like `ffmpeg`, `heif-convert`, and `jpegtran`) are detected on the system. Rather than spawning `which`, or asking PowerShell for the binary path, we now walk `$PATH` looking for binaries with `rx` access. If `$PATH` is somehow truncated or invalid, we also walk some default paths (like `%SYSTEMROOT%` on Windows, and `/usr/bin` and `/usr/local/bin` on macOS and Linux).

  This fixes `sqlite.exe not found` and `jpegtran.exe not found` errors on Windows, and should fix SQLite backups on Windows.

- 🐛 Fixed [o.toLocal is not a function](https://forum.photostructure.com/t/2-1-0-alpha-7-library-build-fails-sync-report-mentions-typeerror-o-tolocal-is-not-a-function/1638), caused if an asset file fails to extact a captured-at time. (Thanks for reporting, @pmocek!)

- 🐛 Fix `AssetFile` constraint violation during the asset file cleanup in rebuilds. This could prevent library rebuilds from completing successfully.

- 🐛 If an Apache reverse proxy closed the SSE socket, PhotoStructure would pop up a "🌩 Not connected" error. This build skips showing that error and tries to quietly restore the SSE socket when broken. [See this forum post for details.](https://forum.photostructure.com/t/repeated-not-connected-toast-message-when-running-behind-reverse-proxy/1694)

- 🐛 PhotoStructure can now [allow drives to go to sleep](https://forum.photostructure.com/t/photostructure-doesnt-let-your-drives-go-to-sleep/18/3). It should "just work," but to set `volumeMetadataTtlMs=0` and `mountpointsTtlMs=0` to force this behavior on platforms that don't have mountpoint-change-watcher functionality. `mountpointsTtlMs` defaults to 0 on docker now, btw.

- 🐛 Fixed off-center home icon on Safari (the `displayPath` for the root tag was `[ null ]`, oops)

- 🐛 Note: file picker dialogs on PhotoStructure for Desktops that use Linux Gnome can pop-under as a "feature" of Gnome. See <https://github.com/electron/electron/issues/32857> for details.

- ✨/📦 System load is now exposed in the about page and the `info` tool.

- ✨/📦 File I/O was reduced a bit--permission checks now directly use the `Stats` object if cached, rather than requiring a separate `access()` I/O call.

- ✨/📦 "Actual path" resolution on case-insensitive systems now ensure the correctly-cased pathname is used for URIs. Incorrect case could prevent cross-platform asset file correlation.

- ✨/📦 The new `fsCacheSlowMs` setting supports sharing work, like image hashing and metadata parsing and inference, between processes, which can avoid duplicating work during asset importing.

- ✨/📦 The new `siblingInference` setting helps PhotoStructure work around (very) large directories. See the setting for details.

- 📦 PhotoStructure now requires at least Node.js v16, and is tested on 18 and 20.

- 📦 System load on macOS and Linux now average together both proc/cpu metrics as well as loadavg(), which should help PhotoStructure throttle work more accurately.

- 📦 Control SQLite's [synchronous mode](https://sqlite.org/pragma.html#pragma_synchronous) via the new `dbSynchronousMode` setting.

- 📦 If file copies are problematic (you'd see `warn` log entries to this effect), you can now force PhotoStructure to use `cp -af` (on macOS and Linux) or `Copy-Item` (on Windows) by setting the new `onlyNativeFileCopy` setting to `true`.

- 📦 Control PowerShell child process concurrency via the new `powerShellProcs` setting

- 📦 Added support for newer NEF and old KDC image formats

- 📦 New setting `twoDigitCutoffYear`: sets the cutoff year after which a string encoding a year as two digits is interpreted to occur in the current century. As an example, a value of "50" would make "49" be interpreted as 1949, and "50" as 2050. See <https://moment.github.io/luxon/api-docs/index.html#settingstwodigitcutoffyear> for details. This defaults to 3 years in the future (modulus 100) and is updated automatically.

- 📦 Some string handling previously used now-deprecated `.substr()`. PhotoStructure now uses locale-aware grapheme splitting where available, which should prevent high-unicode text from being corrupted.

- 📦 Volume UUID files, .JSON files, and .TOML files all now support UTF-8, UTF-8-with-BOM, and UTF-16LE-with-BOM encodings, and are now normalized before `volsha()`'ed (so `{abc-012-789}` will be considered equivalent to `abc012789`)

- 📦 Added 20 new serial-to-model-name translations for recently released smartphones and cameras

- 📦 Pulled in latest versions of Electron, sharp, node, TypeScript, ExifTool, and other third-party libraries.

- 📦 When spinning up the `photostructure/server` docker image, better error messages are now emitted when `/ps/library` is missing.

- 📦 Mountpoint and volume extraction is now more configurable. See the new `excludedFilesystemTypes`, `excludedRootDirectories` and `excludedMountpoints` settings. `isExcludedMountpoint()` now debug-logs _why_ a given mountpoint is excluded, to help tune these settings.

- 📦 Process `renice`-ing and management should be more efficient, as PhotoStructure now defaults to libuv and only resorts to external tooling on failure.

- 📦 Supported file extensions and mimetypes are now defined in a single dictionary to ensure they are kept in synchronization. Due to the prior design, several more obscure file extensions (like `.KDC`) weren't handled properly.

- 📦 Removed `--progress` from `sync` (it wasn't used, and was an unnecessary third-party dependency)

- 📦 Most URLs in text files and emitted to stdout were wrapped in angle brackets, but some apps would interpret the trailing `>` was part of the URL (looking at you, UnRaid terminal), which 404ed. All wrapped URLs are just plaintext, separated with whitespace.

- 📦 Replaced "open library" locks with critical section file mutexes. This should avoid "this library is already open on \$host" startup errors while still preventing concurrent system access. This means the `--force-open` argument for many of the tools is now gone.

- 📦 [Volume UUIDs](https://photostructure.com/faq/what-is-a-volume/#-logical-volume-uuids) are now customizable, and support multiple paths. See the new `volumeUuidFilePaths` Setting for details.

- 📦 Camera and lens UUIDs are whitespace-normalized before being hashed (as RAW and JPG variants can sometimes only differ in spaces (!!))

- 📦 Added Make/Model support for 20+ new flagship cameras

- 📦 Added `.Make` backfiller from `Software` and `CreatorTool` tags (useful for scanners)

## Prior release notes

- [**Release notes from 2022**](/about/2022-release-notes)

- [**Release notes from 2021**](/about/2021-release-notes)

- [**Release notes from 2020**](/about/2020-release-notes)

- [**Release notes from 2019**](/about/2019-release-notes)
