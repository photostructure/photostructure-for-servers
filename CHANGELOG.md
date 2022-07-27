
This is a detailed list of changes in each version.

- Major version releases have posts summarizing bigger changes. See [the posts tagged with "release notes"](/tags/release-notes/).

- **Stable, released versions are recommended.** [See the forum post for details about alpha, beta, and stable releases.](https://forum.photostructure.com/t/alpha-beta-stable-and-latest-what-should-you-use/274)

- "Pre-release" builds (those that end with `alpha` or `beta`) have not been thoroughly tested, and may not even launch.

- Only run `alpha` or `beta` builds if you have [recent backups](/faq/how-do-i-safely-store-files/).

- If you update to an alpha or beta build and you want to downgrade to a prior version, know that older versions of PhotoStructure may not be able to open libraries created by newer versions of PhotoStructure. You will probably need to [restore your library from a database backup](/faq/restore-db-from-backup/).

<!-- TODO: -->
<!-- - ✨/🐛/📦/🚫☠ For most cases, PhotoStructure no longer "fails fast." [Read more here](https://forum.photostructure.com/t/disable-photostructure-from-failing-fast/501). -->
<!-- - ✨ Logs are now viewable in the UI -->
<!-- - 🐛 [Tag reparenting doesn't seem to work properly on rebuilds](https://forum.photostructure.com/t/who-tags-are-incorrectly-excluded-from-keywords/676/6?u=mrm). -->

<!-- - 🐛 Sync resume (after pause) on mac via the menubar (not the main window nav button) doesn't seem to support "resume" properly -->

<!-- - 🐛 [Incremental syncs find new folders](https://forum.photostructure.com/t/source-directory-not-scanned-after-beta-13-update/867) (I believe this was due to the auto sync-paths but) -->

<!-- incorrect sync status on the about page -->
<!-- progress report shows asset ids https://forum.photostructure.com/t/2-1-0-alpha-1-rebuilding/1473 -->

## v2.1.0-alpha.4

**(to be released)**

- 💔 PhotoStructure for Docker users: If your docker or docker-compose scripts used `$UID`, please switch to using `$PUID`. If you used `$GID`, please switch to `$PGID`.

  Prior releases tried to be "nice" and support **both** `$UID` and `$PUID` (as well as both `$GID` and `$PGID`), but this turned out to be a _bad idea_. `bash` and other commands consider `$UID` and `$GID` to be reserved, read-only, and trustable environment variables, which could cause issues. We'll just stick with the linuxserver.io standard. Details: <https://photostructure.com/go/pgid>

- ✨ Support for remote TCP [GELF-compatible](https://docs.graylog.org/v1/docs/gelf) logging servers via the new `PS_LOG_SERVER` and `PS_LOG_SERVER_LEVEL` settings.

- ✨/📦 "Friendly" duration strings are now supported (after I typoed the fourth ISO duration string). See <https://photostructure.com/getting-started/advanced-settings#duration> for details.

- ✨/📦 Prior versions of PhotoStructure compiled the front-end javascript against an ES5 target, which caused older, unsupported iOS devices to not render the frontend. When we heard that [Nighthawk](https://forum.photostructure.com/u/nighthawk/summary)'s Grandma's iPad didn't work, though, **this had to be fixed**. We know build against ES3, and should support ancient versions of Safari. 

- ✨/📦/🐛 The prior build (`alpha.2` and `alpha.3`) introduced `globs`, but having both `scanPaths` and `globs` resulted in confusion (and several bugs). File exclusion patterns were completely revisited in this build. [Implementation details and usage are explained in this forum post](https://forum.photostructure.com/t/new-in-v2-1-exclude-files-with-globs/1458).

- ✨/🐛 Sidecar handling was improved: `photo.JPEG` now matches up with `photo.JPG.xmp`.

- ✨ When PhotoStructure copies files on macOS and Windows, it now retains file "birthtime" metadata. This isn't a field that exists on standard Linux filesystems, so it's not supported there. Set `retainFileBirthtimes=false` to disable this new behavior. 

- ✨ Lazy loading is now configurable, via the new `lazyLoadExtraVh` setting. Use a smaller value if you're serving your library over a constrained network.

- ✨/🐛 Several [sync report](https://photostructure.com/go/sync-reports) improvements:

  - The sync report directory can be opened via the nav menu (if accessed via localhost), or on PhotoStructure for Desktops, via the tray and system menus.

  - The README.txt now includes a comprehensive list of "states" for files and directories.
  
  - Added a new "at" column that's ISO-date-time formatted, because most spreadsheet apps don't know how to parse millis-from-common-epoch.

  - Sync reports no longer worryingly state that all sidecars were skipped--the sync report now states what file(s) the sidecar will be associated with, and only marked as excluded if they don't match with any sibling photo or video file.
  
  - Sync reports now include a "started" state emitted after being dequeued from the work queue.
  
  - Prior sync report CSVs could contain a "details" cell that included newlines. Although Excel and LibreOffice parse these CSVs properly, Google Sheets don't, and there was discussion asking if these newlines could be avoided. _Good news, everyone_, `/\r?/n/g` is replaced with `": "` in the details column now!
  
  - If automatic organization is enabled (see the `copyAssetsToLibrary` setting), a new sync report row will be added when photos and videos are copied into your library.

- ✨/🐛 When sync finishes for a given path, and `retryEnqueued` is `true`, `sync` will look at the last day of sync reports for paths that are "stuck"--paths that have a "enqueued" entry, but no subsequent "synced", "timeout", or "failed" entry, and retry them.

- 🐛 A bug in URI root encoding caused `alpha.2` through `alpha.4` to have several sync reporting and progress panel-related errors, which should now be resolved.

- 🐛 Depending on how PhotoStructure was shut down, the `sync` process could have been force-killed while still closing the database, which would result in `SQLITE_CORRUPT`. A new `syncExitTimeoutMs` setting has been added, which defaults to 1 minute--this should be enough to close SQLite even on the slowest remote HDDs and largest libraries, but now you can extend this if you must.`

- 🐛 Work-in-progress files, (hidden files starting with `.WIP-`), used by metadata extraction and transcoding ops, now use a filesystem mutex to avoid race conditions (this caused random import failures on high-CPU-count servers).

- 🐛 Filesystem watches for the same path are now shared within a given process (Node.js quietly fails when watch is invoked more than 3 times for the same path. Again, this would only impact users with high-CPU-count servers).

- 🐛 Videos and images are no longer considered for aggregation (to avoid spurious live photo matches). (PhotoStructure will revert this when Live Photos are properly aggregated).

- 🐛 PhotoStructure for Desktops has a "pre-flight check" of the library directory at startup. Prior versions could fall into an infinite loop if the directory permissions were wrong.

- 🐛 Library directory suggestions now filter out any directories that are not read-write by the current user.

- 🐛 The "🌩 Not Connected" dialog no longer flashes epi(lepti)cally when the library server isn't available. 

- 🐛 Backend state, liked current running version, isPaused, and current plan is now synchronized with the front-end after every XHR request.

- 🐛 Fixed `./photostructure main --tail` (prior versions would erroneously report the arg as being invalid).

- 🐛 PhotoStructure for Desktop billing links now open in the current window

- 🐛 Due to an unclosed http response, the webserver would hang if previews were missing

- 🐛 Fixed `includedPreviewTags` setting's `capturedAt` and `exposureSettings` support for non-standard tag locations. Preview images are tagged to let Apple Preview and Eye of Gnome properly extract exposure settings.

- 🐛/📦 Reduced db mutex contention during backups by pausing work item dequeues--this could cause tasks to "time out" when they were just waiting for the backup to complete.

- 🐛 The "your library is already open" and "your library is missing" preflight check dialog buttons for PhotoStructure for Desktops didn't work properly. We use the new electron API properly now.

- 🐛 File copies could erroneously timeout under heavy I/O, causing larger file imports to fail randomly. We now use a progress watchdog instead of a hard timeout.

- 🐛/📦 Wrapped PhotoStructure for Desktops launch block in a try/catch to ensure errors got rendered to a user-visible dialog

- 📦 PhotoStructure for Docker: If `$PUID` or `$PGID` aren't "effective" (either the current effective user id doesn't match `$PUID`, or current effective group id doesn't match `$PGID`), all commands (`main`, `sync`, `web`, ...) will now emit a warning with a link to the forum post with the solution: <https://forum.photostructure.com/t/1597/2>.

- 📦 Process shutdown was refactored a bit: 

  - To avoid premature shutdown (and dreaded `SQLITE_CORRUPT` errors), we now fully rely on "endable" component timeouts, rather than having a single top-level timeout. If, say, the db takes a while to shut down, the new code will be patient and wait for it now. Shutdown may take a bit longer, but in testing I haven't measured slower shutdowns.
  
  - Child processes now listen on `stdout` for `--exit`, process signals, and the new `exit` shared-state event to initiate shutdown.

- 📦 Volume and mountpoint parsing now uses the `validateMountpoints` setting to only return user-`rX` directories.

- 📦 Expired subscription licenses are now auto-refreshed after upgrading to a new major/minor version.

- 📦 Multiprocess state sharing is now lockless to avoid multi-process deadlocks in `alpha.3`.

- 📦 Advisory locks use filesystem mutexes, rather than relying on SQLite unique constraints.

- 📦 Improved `info --exclude-globs` output

- 📦 File SHAs are cached and invalidated only if `fs.Stats` `size` or `mtimeMs` change. Prior versions would invalidate previously-cached SHAs too aggressively, which could result in the entire file being re-read several times unnecessarily.

- 📦 Pulled in latest versions of Electron, sharp, node, typescript, ExifTool, and other third-party libraries.

## v2.1.0-alpha.3 (server)

**[Released 2022-06-08](https://forum.photostructure.com/t/version-2-1-0-alpha-2-is-ready-for-testing/1507)**

- 🐛 This version was only released on server editions, and fixes the `su` error in `docker-entrypoint.sh`.

## v2.1.0-alpha.2 (desktop)

**[Released 2022-06-08](https://forum.photostructure.com/t/version-2-1-0-alpha-2-is-ready-for-testing/1507)**

- ✨ A separate, native Apple Silicon build is now available for macOS users (we didn't go with a universal, or "fat" build, as the "thin" builds are twice as fast to download and take up half of the disk space--a universal build would have been close to 500MB, uncompressed!).

- ✨ PhotoStructure now supports powerful "include" and "exclude" patterns via [the new `globs` setting](https://forum.photostructure.com/t/new-in-v2-1-file-globbing/1458). This replaces the prior `neverIgnored` setting.

- ✨ The asset header now supports direct downloading of the original asset

- 🐛 On Linux and macOS, `sync` no longer walks into nested mountpoints (this broke sync status and post-sync cleanup operations, like detecting deleted files).

- 🐛 Fixed Windows launch bug `%SYSTEMROOT% not set`. PhotoStructure now uses case-insensitive environment key lookups on Windows.

- 🐛 Fixed Windows `missing Z:\proc\cpuinfo` fatal error.

- 🐛 On macOS, the default Apple Photos library is now appended to the "include" glob patterns.

- 🐛 `ffmpeg`'s `singlejpeg` support was dropped in new builds. Adjusted PhotoStructure's frame extraction command to suit.

- 💔 Several web security settings were changed. [See the forum for details.](https://forum.photostructure.com/t/version-2-1-0-alpha-is-ready-for-testing/1456/12)

  - 📦 The `trustProxy` setting default was changed from `false` to `loopback`. If you use PhotoStructure via a reverse proxy, please refer to the documentation associated to the setting, visit <http://expressjs.com/en/guide/behind-proxies.html>, or ping us on Discord for help.

  - 📦 The `upgradeInsecureRequests` setting defaults to `false`. If any `https` request is detected, however, PhotoStructure changes the default to `true`. **If you access your library via both `http` and `https`, explicitly set this setting to `false`.**

  - 📦 The `enableWebSecurity` setting was confusing, and was deleted.

  - 📦 A new `disabledHelmetMiddleware` setting supports configuration of [Helmet](https://github.com/helmetjs/helmet#reference).

  - 📦 All web security settings are now all gathered in a new `Security` category

- 📦 `logtail` now accepts a log directory to tail recursively

- 📦 Docker multistage builds took 40+ minutes on GitHub Actions. A [new cached base image](https://github.com/photostructure/base-tools) speeds up rebuilds to be just a minute or two.

- 📦 The `info` tool now lists all `.JSON`, `.XMP`, `.MIE`, and other sidecar files for the file(s) being examined. [See the forum for details.](https://forum.photostructure.com/t/increasing-confidence-in-the-import/1476/5)

- 📦 File watching is now debounced and can squelches stat changes if the SHA doesn't change. See the new `watchDebounceMs` setting for details. This fixes the mountpoints watcher from declaring "detected change in /proc/mounts" every minute on linux systems.

- 📦 A bunch of [settings](https://photostructure.com/getting-started/advanced-settings/) housecleaning:

  - The `Volumes` and `Files` categories were merged into a new `Filesystem` category
  - The `Timeouts` category was deleted, and contents moved into proper categories (like `maxSyncFileTimeoutMs` moved to `Sync`)
  - A new `Security` category was added (see above)
  - `maxEmbeddedBuffer` moved to `Previews`
  
- 📦 `./photostructure info --cleanup` (whose process is normally performed automatically by `sync`) now vacuums stale image caches, readdir caches, shared state, previews, advisory locks, and logfiles. Add `--info` to see what it's doing.

- 📦 [Third-party tools were
  rebuilt](https://github.com/photostructure/photostructure-for-servers/tree/alpha/tools),
  and compilation instructions were added as READMEs.

<a id="v210-alpha0"></a>

## v2.1.0-alpha.1

**[Released 2022-05-05](https://forum.photostructure.com/t/version-2-1-0-alpha-is-ready-for-testing/1456?u=mrm)**

We're skipping a release of 2.0, as the changes in this release are substantial enough to return to "alpha" status.

A lot has changed behind the scenes, including a substantial refactor of process scheduling that should address sync and database issues several users have reported, and better sync visibility, thanks to the new sync reports.

Note for PhotoStructure for Servers users: `sync-file` is no longer an available command. Prior commands that used `sync-file` should switch to using `sync`.

The `sync` process now supports `--progress`, which exposes real-time import progress.

<!-- TODO: -->

- ✨ Sync imports should be substantially faster, especially for larger libraries.

  - The `syncIntervalHours` setting was renamed to `syncNewIntervalHours`. This setting ensures detection of _new_ photos and videos happen daily (by default).

  - A new `syncChangedIntervalHours` setting, which defaults to weekly, detects _changes_ made to previously imported photos or videos.

  - Typical `sync`s should take several orders of magnitude less disk I/O to complete, as they only have to `readdir` every directory, and not `stat` every file.

  - System profiling identified several hotspots, including tag recounting, which has been optimized (the 10-15s process now completes in under a second)

  - DB vacuuming, tag, and search maintenance is now rate-limited with dynamic TTLs based on the size of the library

- ✨ New sync reports are now emitted into `$library/.photostructure/sync-reports/`. [See the forum post for more details.](https://photostructure.com/go/sync-reports)

- ✨/🐛 Deduplication improvements:

  - If the file extension matches, we respect the millisecond captured-at precision. If the file extension doesn't match, the precision minimum is set to 1 second, as some DSLR encode RAW/JPEG pairs with slightly (< 1s) different captured-at times.

  - The `imageId` and `cameraId` EXIF UID values now support "synonym groups", like `ImageNumber`/`ShutterCount` and `CameraSerialNumber`/`SerialNumber`.

  - `cameraId`, `imageId`, and `lensId` tag synonyms are now coalesced (Nikon uses `ImageNumber` on JPG and `ShutterCount` on NEF).

  - Lens matching now uses a normalized lens information value. This allows for Nikon JPG/RAW pairs to be matched correctly. (Nikon's latest bodies encode _a different value for the same lens_ when looking at `.NEF` vs `.JPG`).

  - Bogus `ShutterCount:1` and `0000000` tag values are ignored.

- ✨ New `assetPathnameFormat` setting to customize automatic organization, which supports `BASE`, `NAME`, `EXT`, `PARENT`, and `ISO` tokens. See [this forum post for more details](https://forum.photostructure.com/t/how-to-change-the-naming-structure/1184/2?u=mrm).

- ✨ New filter setting `respectFileExtensions`: Normally PhotoStructure uses file extensions (like `.JPEG` or `.MP4`) to perform initial file filtering, which is much faster than having to open and examine the initial bytes of every file. If you have files that don't use valid file extensions, you can set this to false, but know that file imports will be much slower.

- ✨ New filter setting:`maxVideoDurationSec`, the maximum number of seconds that a video can be and still be imported. If this is set to 0 or unset (the default), no maximum duration limit will be applied.

- ✨ `sync` now supports `--progress` which shows the real-time status of every concurrent file import. Note that this mode requires an ANSI-color terminal.

- ✨ `info` now has `--cleanup` and `--recount-all-tags` switches to manually run periodic maintenance tasks, including tag count updates, search index rebuilds, and database optimization, vacuuming, verification, and backup. These tasks are normally done by `sync`.

- ✨ `info` now has `--mountpoints` to show... _mountpoints_.

- ✨ `info --filter` supports "deep" value picks, like `info --filter "paths.libraryDir"`, which can be handy with `--flat`.

- ✨ `info --validate` supports command-line file validation.

- ✨ New ["easy mode" for Docker bind-mounts](https://forum.photostructure.com/t/new-easy-mode-for-docker-coming-in-v2-1/1278/1).

- ✨ New ["quick (and dirty) mode"](/server/photostructure-for-rpi/) for Raspberry Pis. RPi detection and licensing were improved (and works within Docker now).

- ✨ Automatic sync throttling: when importing assets on slower disks and servers with many (8+) cores, imports can lead to PhotoStructure hitting disks "too hard" and the import process can get "stuck". PhotoStructure will now automatically throttle back concurrency to approach `maxConcurrentImportsWhenRemote` as we get disk I/O timeouts, to try to avoid hammering disks.

- ✨ "Re-sync this asset" now looks for deleted, rejected, or filtered files and removes those references from the synced asset.

- ✨ Support excluding photos and videos tagged with specific keywords with the new `keywordBlocklist` setting: [see the forum for details](https://forum.photostructure.com/t/excluding-media-with-specific-tags/1351).

- ✨ Newer versions of Firefox and Chrome don't like non-https websites with CSP and CORS headers: PhotoStructure will automatically disable those headers for PhotoStructure for Desktops, or if `exposeNetworkWithoutAuth` is `false`, but you can specify the correct setting with the new `enableWebSecurity` setting.

- ✨ All settings ending in `Ms` (for **M**illi**s**econds) and `Duration` now accept [ISO 8601 duration strings](https://en.wikipedia.org/wiki/ISO_8601#Durations), "friendly" durations, as well as numeric values which will be interpreted as milliseconds. See <https://photostructure.com/getting-started/advanced-settings#duration> for details.

- ✨ **Stable inferred tags for library copies**. PhotoStructure uses "sibling" files to backfill missing metadata. When photos and videos are copied into your library, there may not be siblings to restore the "inferred" metadata, and that could cause issues with tagging and imports.

  This version will write inferred tags to the `History` XMP tag, so when metadata is missing in your library assets, PhotoStructure can recover that prior inference work.

- ✨ The new `defaultCopyright` (which is disabled by default) gives a default value to the `Copyright` tag.

- ✨ **Preview images can now retain original metadata**. Prior versions of PhotoStructure would strip all metadata from preview images to speed up rendering. The new `includedPreviewTags` setting (which defaults to `AttributionName`, `AttributionURL`, `capturedAt`, `Copyright`, `License`, `Make`, `Model`, `Permits`, `Prohibits`, `Requires`, `Source`, and `UseGuidelines`) will use a few more bytes for every preview image, but avoid metadata-less images. Set this setting to `""` to disable this feature.

- ✨ The new `writeSourceTagToLibraryCopies` setting (which defaults to `false`) will write a sidecar containing the `Source` tag for all new files copied into your PhotoStructure library whose value is the full native path to the source file.

- ✨ Setting `cpuLoadPercent` to `1` or `0` now puts sync into "single-threaded mode", which minimizes forking and memory consumption.

- ✨ New `strictDeduping` "meta" setting requires exact-match captured-at values
  (changing this value requires a library rebuild to re-aggregate your assets). It also
  enables `useImageHashes`, and cranks up `minExposureSettingsCoeffPct` to 98,
  `minImageCoeffPctWithExactDate` to 95, `minImageCoeffPctWithFuzzyDate` to 95,
  `minGreyscaleImageCoeffPct` to 95, `minColorCoeffPct` to 95, `minMeanCoeffPct`
  to 95, `modeCorrCieDiffWeight` to 1, and `modeCorrIndexDiffWeight` to 1

- ✨/🐛/📦 Fixed/improved timezone handling: See the update to [exiftool-vendored](https://github.com/photostructure/exiftool-vendored.js/blob/main/CHANGELOG.md#v1600) for details.

- ✨/📦 Several additional lenses are now properly parsed, including Nikon VR and ZEISS Batis glass.

- ✨/📦 The `main` and `info` services verify that `PS_*` environment variables are known PhotoStructure environment variables. If any incorrect settings are found, the closest-named setting is suggested. This is only a warning emitted to `stdout`.

- ✨/📦 Docker containers can now safely bind-mount `/tmp` to `/ps/tmp`: PhotoStructure will automatically add a subdirectory, chmod'ed to `700`, when running in Docker. [See this forum post for details](https://forum.photostructure.com/t/cant-mount-my-photos-share/1249/3?u=mrm).

- ✨/📦 Added `.env` support via `PS_ENV_FILE`: [read more here](/faq/environment-variables/#PS_ENV_FILE)

- ✨/📦 File path to URI construction is more reliable, delegating to previously cached volume metadata.

- ✨/📦 Added [Next/Back buttons to the settings page](https://forum.photostructure.com/t/moving-photostructure-to-a-new-computer/1065/7?u=mrm)

- ✨/📦 `logtail` and `logcat` are dramatically faster for very large inputs, and handle stream buffering gracefully (handy if you pipe contents through `less`)

- ✨/📦 Deprecated settings (currently `scanMyPictures`, `assetSubdirectoryDatestampFormat`, and `syncIntervalHours`) are now automatically migrated to the setting that replaced them (if those settings are unset).

- 🐛 Restored the title bar on PhotoStructure for Desktops's About page

- 🐛 Progress panels on the home page are now restored.

- 🐛 A new database migration was added to unset any invalid `Asset.excludedAt` or `Asset.deletedAt` column values, avoiding spuriously-removed or deleted assets.

- 🐛 CSP directives had to be adjusted due to new Chrome `form-action` enforcement. See the `cspDirective` and `cspReportOnly` settings for details.

- 🐛 Zoom widgets aren't hidden on touchscreen laptops anymore

- 🐛 Improved is-file-deleted detection (volume SHAs are now used in addition to native paths to ensure we're referencing the same path)

- 🐛 [GIO](<https://en.wikipedia.org/wiki/GIO_(software)>) volumes are now properly extracted on Ubuntu 20+.04.

- 🐛 Fixed zooming into rotated non-JPEG images (prior versions could incorrectly rotate image-actual)

- 🐛/📦 Cleaned up network error message "toasts" to be consistent.

- 🐛/📦 Work to [reduce `SQLITE_BUSY` errors](https://forum.photostructure.com/t/initial-library-build-processing-pauses/1266/2?u=mrm): `sync` now uses threads rather than `sync-file` processes, and only `sync` reads and writes to the library database. This results in more work done by the `sync` process, but all CPU-intensive work (like image validation and preview generation) is offloaded to threads and a new child `worker` process., and overall sync throughput should be higher, especially on high-core machines and larger libraries where write contention can wedge `sync`.

- 🐛/📦 Photos and videos copied into the library are now both checked for previously-existing SHA clones both by using the library and by looking at directory ancestors' files that contain common core filename basenames.

- 🐛/📦 The "Skipping to first non-empty child tag…" tag only shows once for a specific tag redirect (thanks for the suggestion, Aidan!)

- 🐛/📦 Work to prevent DB corruption:

  - Database janitorial work is now only done by `sync`

  - `main` doesn't open DB connections anymore

  - DB backups are only done by `sync`

  - Code that could have resulted in a partial DB replica copy now uses the work-in-progress file copier

- 🐛/📦 System profiling found that `readdir` was a hotspot, but the prior caching approach overwhelmed the garbage collector. The new caching `readdir` avoids filesystem caching if `readdir()` returns quickly, resulting in a 10x speedup (!!)

- 🐛/📦 The `rpcPort` setting (and all inter-process RPC ports) were deleted. All shared state between processes is now coordinated via a new `$config_dir/shared-state.json` file, where `$config_dir` is the same directory that stores [system settings](https://photostructure.com/getting-started/advanced-settings/#system-settings). This both simplifies the codebase and allows any process to broadcast persistent or transient events at any time.

- 🐛/📦 Sidecar matching has been improved to unicode-normalize strings and match file copies with numeric copy suffixes

- 📦 `sync-file` has been removed, as it is no longer used by `sync`. Manual file and directory imports can be done via the `sync` tool.

- 📦 `MetadataDate` was removed from the default set of "captured-at" tags, as this tag encodes the _last time metadata was edited_, not the time that the asset was captured.

- 📦 Volume metadata is now cached on the filesystem (in both the library and the system config directory) to let PhotoStructure handle kernel hiccups where volume metadata goes missing (like with macOS after suspend, or Windows when it feels sad).

- 📦 `PS_MOUNTPOINTS_TTL_MS` now defaults to 0 on Linux and macOS, and 15 minutes on Windows. This reduces no-op work for scanning mount points.

- 📦 Added a couple of new splash backgrounds because why not

- 📦 Reduced `sync` GC load and memory consumption by more than 2x by refactoring several performance hotspots including caching, filesystem iteration, mutexes, and bounded concurrency.

- 📦 Docker container license validation is a bit more robust now. Apologies if you needed to re-authenticate: if you see this happen, [please report it](https://forum.photostructure.com/t/how-often-should-i-have-to-reauthenticate/1200)!

- 📦 Hung child processes (like `df` when eth0 drops) are proactively cleaned up

- 📦 Improved test coverage: several hundred additional test suites were added, especially around tag management, DB transactions under heavy write contention, and concurrency management

- 📦 Error events are now written with month (not day) resolution, to prevent the same error reported more than once a month.

- 📦 Moved `scanLibraryFirst` and `scanLibraryLast` to library "sync" settings category, and renamed them `syncLibraryFirst` and `syncLibraryLast`. The previous names were added as aliases, so prior configuration changes will be migrated to the new names. The `syncLibraryFirst` setting now defaults to `true` if `copyFilesIntoLibrary` is true, to make sure we know what's in your library before copying more stuff in there.

- 📦 Memory and CPU metadata now respect container quotas (like when under Kubernetes). Thanks for the suggestion, [Stephonovich](https://www.reddit.com/r/PhotoStructure/comments/sn68f9/comment/hw4bqmj/)!

- 📦 [`streamFlushMillis`](https://photostructure.github.io/batch-cluster.js/classes/BatchClusterOptions.html#streamFlushMillis) can be adjusted as a setting, and will automatically be increased if PhotoStructure detects stderr/stdout synchronization issues due to slow/overwhelmed systems.

- 📦 Mountpoint watching is more reliable on Ubuntu and Alpine. We now use both a file watcher on `/proc/mounts` and `findmnt --poll` if available, and parse the content directly, rather than forking `mount` and parsing that content.

- 📦 PhotoStructure's (extensive!) continuous integration test suite now runs on macOS, Windows, Ubuntu, and Alpine (prior versions didn't include Alpine)

- 📦 Upgraded Docker container to Alpine 3.15/Node 16 LTS and the latest stable, audited release for all third-party code.

- 📦 Deleted `logElapsedMs` setting to simplify log formatting code

- 📦 New `minDelayBetweenSpawnMs` setting allows for adjustment of process load ramps

- 📦 New `enableWebSecurity` setting supports disabling CSP and CORS when on localhost. See the setting for details.

- 📦 New `maxRetries` setting lets `sync` retry file imports. If you have a flaky network, or if your computer shows up late for work because it had a hard drive, this can help ensure imports are comprehensive. The default is `1`. Set this to `0` to disable retries.

- 📦 New `ignoredFilesystemTypes` Linux-only setting lets you tell PhotoStructure not to walk into non-fs mountpoints. The default of `["cgroup", "debugfs", "gvfsd-fuse", "none", "sunrpc", "sysfs", "tracefs"]` should work for most people. If you need to edit this, please pop into the forum or Discord and tell us!

- 📦 Cache dirs `rm -rf`ed when database migrations are applied. This will fix incorrectly-rotated cached preview HEIFs.

## Prior release notes

- [**Release notes from 2021**](/about/2021-release-notes)

- [**Release notes from 2020**](/about/2020-release-notes)

- [**Release notes from 2019**](/about/2019-release-notes)
