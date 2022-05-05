
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

## v2.1.0-alpha.0

**Released 2022-05-05**

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

- ✨ New sync reports are now emitted into `$library/.photostructure/sync-reports/`. [See the forum post for more details.](https://forum.photostructure.com/t/show-more-import-and-sync-details/218/9?u=mrm)

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

- ✨ All settings ending in `Ms` (for **M**illi**s**econds) and `Duration` now accept [ISO 8601 duration strings](https://en.wikipedia.org/wiki/ISO_8601#Durations), as well as numeric values which will be interpreted as milliseconds.

  These strings certainly aren't the _prettiest_ to look at, but they're well-specified, you don't have to waste your time counting zeros or dividing by 60.

  - 8601 duration strings always start with `P`.
  - Hour, minute, and second values follow a `T`.
  - PhotoStructure lets you use lowercase, if you prefer.

  Here are some examples:

  - `P1D` is 1 day
  - `PT20M` is 20 minutes
  - `p4dt5h6m7.890s` is 4 days, 5 hours, 6 minutes, 7 seconds, and 890 milliseconds.

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
