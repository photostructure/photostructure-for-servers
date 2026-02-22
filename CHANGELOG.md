
<div class="release-notes">

## v2026.2.0-beta - To be released

{{< note >}}
This version has not yet been released. We hope to release it soon!
{{< /note >}}

Check out the [v2026.2](/about/v2026.2/) release notes for higher-level information about this release.

### ⚠️ Breaking changes

#### Node.js 22.3+ required

PhotoStructure now requires Node.js 22.3+, 24.x, or 25.x. Node.js 20, 21, and 23 are not supported. The minimum was bumped from 22.2.0 for `zlib.crc32` support. This only applies to PhotoStructure for Node users; Docker and Desktop editions bundle a compatible Node.js runtime automatically.

#### `resyncAssetOnVisit` setting removed

This deprecated setting has been removed. Directory resync is now handled through the Sync Activity page's "Resync" button, which writes a `forceSyncPath` operation and restarts sync.

#### File copy settings consolidated into `fileCopyStrategy`

The boolean settings `fileCopyOnlyNative` and `fileCopyWithReflink` have been replaced with a single `fileCopyStrategy` setting. See [How PhotoStructure copies your files](/faq/file-copy-strategies/) for details on available strategies, TrueNAS troubleshooting, and configuration options. Thanks for the report, Zandr!

### ✨ New features

#### Sync Activity page

The new Sync Activity page (`/sync`) provides real-time visibility into what PhotoStructure is doing:

{{< figure src="/img/2026/01/sync-activity.jpg" alt="Sync Activity page showing live feed, scanned directories, and sync reports" >}}

- **Live feed**: Watch sync activity in real-time with filters for imported, excluded, and error rows
- **Real time control**: Pause, resume, restart, and rebuild on demand
- **Scanned directories**: See each directory's sync status, file counts, and next scheduled sync time
- **Running tasks & performance timings**: Monitor active tasks and identify bottlenecks
- **Stalled tasks**: Identify tasks that appear to have stalled during sync
- **Problematic files**: View files that have caused sync issues, with strike counts and cooldown status
- **Sync reports**: Download detailed CSV reports with optional filtering
- **Log files**: Quick access to recent log files for troubleshooting

#### 🏷️ Apply tag renames to existing tags

The new `fix --apply-tag-renames` command retroactively applies your `tagPathRenames` settings to existing tags in the database. Previously, `tagPathRenames` only affected newly-imported tags. Now you can rename or reorganize tags without rebuilding your library.

Example: If you've configured `tagPathRenames = { "USA" = "United States" }`, running `photostructure fix --apply-tag-renames` will rename all existing "USA" tags to "United States", including updating all child tags and merging with any existing "United States" tags.

#### 📝 Log flight recorder

PhotoStructure's logging system now includes a "flight recorder" that captures recent log entries even when they're below your configured log level threshold. When an error occurs, these buffered entries are automatically flushed to the log file, providing debugging context about what happened leading up to the error. Configure with `logFlightRecorderCapacity`, `logFlightRecorderMinLevel`, and `logFlightRecorderTriggerLevel` settings.

#### 🐕 Progress watchdog

A new system-wide health check detects when sync becomes "wedged" - stuck with no task completions for a configurable timeout while work is pending. Unlike the previous approach that reacted to individual task aborts, this detects genuine sync stalls regardless of whether specific tasks are timing out. When wedged, PhotoStructure automatically marks running tasks as problematic and restarts sync. Configure with `progressWatchdogTimeoutMs` (default: 5 minutes).

#### ⚖️ Three strikes policy for problematic files

Files that cause sync problems now accumulate "strikes" with progressive cooldown periods:

- **1st strike**: File is blocked for 24 hours, then eligible for retry
- **2nd strike**: Blocked for 48 hours (cooldown × strike count)
- **3rd strike**: Permanently blocked until strikes decay

Strikes automatically decay after 45 days, allowing files to rehabilitate if the underlying issue is fixed (PhotoStructure update, network stabilized, file repaired, etc.). This handles "innocent bystander" files that were running during a wedge but weren't the cause - they get one strike that eventually decays. Problematic file data is now stored as JSON instead of in the database, ensuring it's persisted even if the database is the source of the wedge. Configure with `problematicCooldownMs`, `problematicMaxStrikes`, and `problematicDecayMs`.

#### 🎨 Greyscale vs color mismatch detection

The asset matching algorithm now detects when one file is greyscale and another is color, preventing incorrect groupings of black-and-white versions with their color originals.

{{< note >}}
**Note for beta users**: Earlier beta documentation mentioned a configurable `assetMatching` setting with `all`, `any`, and `primary` modes. We found fundamental issues with the `any` and `primary` strategies that caused incorrect groupings. PhotoStructure now uses only the `all` strategy (complete-link clustering), which prevents chaining.
{{< /note >}}

#### 🌍 Multi-language root tag aliases

New `rootTagWhatAliases`, `rootTagWhenAliases`, `rootTagWhereAliases`, and `rootTagWhoAliases` settings let you define equivalent terms for root tag categories in multiple languages. For example, configure "Quoi", "Was", and "Qué" as aliases for "What" to normalize tags from multilingual photo libraries. See [forum discussion](https://forum.photostructure.com/t/support-for-different-languages-tags-in-lightroom/2474).

#### 🙈 Hidden root tags

The new `hiddenRootTags` setting lets you hide specific root tag categories from the navigation menu. For example, set `hiddenRootTags = ["Who"]` to hide the "Who" category if you don't use face tagging.

#### 👤 "View by Who" navigation

Added "View by Who" option to the navigation menu for quick access to person/face tags.

#### 🩺 Error acknowledgement and service errors health check

The health page now shows a dedicated health check for recent fatal service errors. When errors are present, an "Acknowledge" button lets you dismiss them and restart sync directly from the health page. Acknowledged errors are archived (moved out of the active fatal log directory) so they don't resurface. A new "Recheck health" button also lets you refresh health status on demand.

#### 🐳 Docker healthcheck improvements

The Docker healthcheck command now supports configurable port and parameters, making it work correctly with non-default `PS_HTTP_PORT` configurations.

#### 🔗 Troubleshooting URLs in fatal errors

When PhotoStructure encounters a fatal startup error, the error message now includes relevant troubleshooting URLs to help you resolve the issue without searching the documentation.

#### 📊 Progress panel markdown

The progress panel now renders markdown in status messages, including links to relevant documentation and formatted text.

#### 🔑 SHORTSHA token for library copies

New `SHORTSHA` token available in `assetPathnameFormat` for deterministic library copy filenames. This prevents nondeterministic naming when multiple files compute to the same library path.

#### 🏥 Workers health check

New health check monitors worker process status and reports issues when workers are unhealthy or unavailable.

#### ⚙️ `singleThreaded` setting

New `singleThreaded` boolean setting forces single-CPU operation, exposed in the system load health check. Replaces the old magic `cpuBusyPercent=1` behavior.

#### 🌍 Majority-vote timezone inference

Tag inference now uses a majority-vote timezone from sibling files, improving accuracy when files in the same directory have mixed timezone metadata. The `siblingInference` enum has been replaced with the `inferenceSiblingRadius` integer setting for finer-grained control over how many neighboring files are considered.

### 🐛 Bug fixes

- **Month view missing new months**: Fixed monthly tag views not showing newly-added months after initial sync. When new photos were added for a month that didn't exist before (e.g., adding February photos after January already existed), the monthly breakdown wouldn't appear until the server restarted. The tag redirect cache now properly invalidates when child tags are created. (Thanks for the report, tkohhh
!)

- **iOS Photos metadata excluded**: iPhone backup directories containing `PhotoData/Metadata/DCIM/` are now automatically excluded. These directories store adjusted image data that shouldn't be imported as separate assets.

- **Keywords**: Fixed "TypeError: e.trim is not a function" error when importing photos with ACDSee Categories metadata containing numeric category names (like album years). Reported by kayhadrin.

- **CLI**: Fixed `--pidfile` argument not accepting a path. Thanks for the report, B!z0.

- **Daemon mode**: Fixed `EPIPE` crash when running PhotoStructure with `-d` flag. The daemon child process would crash immediately after the parent exited due to broken `stdio` pipes. Thanks for the report, B!z0.

- **EPIPE nightmare**: Many many moons ago, we added a `SIGPIPE` handler to the web service to avoid crashes from Firefox's sloppy connection handling. However, newer versions of Node.js/libuv ignores `SIGPIPE` by default (`SIG_IGN`). HOWEVER, if you register a listener with process.on("SIGPIPE", ...), `libuv` calls `uv_signal_start()` which **REPLACES** `SIG_IGN` with a real handler. This causes `SIGPIPE` to be **delivered** instead of ignored, making writes to broken pipes fail with `EPIPE` and crash the service. YAY SOFTWARE ENGINEERING. See https://github.com/libuv/libuv/issues/2435

- **Directory exclusion filters now apply to existing files**: Adding directory patterns to `excludeGlobsAdd` (e.g., `**/cats/`) now correctly removes matching files that were already imported. Previously, directory-level filters were only evaluated during initial discovery, not when re-syncing existing files. Thanks for the report, Nighthawk!

- **Finalization death loop**: Corrupt or unrenderable files could cause infinite finalization retries. A new `failedFinalize` flag gives files two chances, then moves on. Force-restarting sync clears the flag globally.

- **Error grouping masking severity**: The crash/resource error category could mask count-based severity thresholds, hiding relevant health check warnings.

- **RPC timeout handling**: Sync RPC requests could hang indefinitely. Added timeout handling to prevent the web service from becoming unresponsive.

- **Mobile breadcrumbs**: Fixed breadcrumb elements overlapping on small screens.

- **Sync restart logic**: Improved sync restart decisions based on health check levels, preventing unnecessary restarts when health checks change.

- **Tag asset counts**: Fixed NULL accumulation in tag `assetCount` when tags were created without an initial count value.

- **Dropdown click handling**: Interactive form controls (row/aspect toggles) inside dropdowns no longer cause the dropdown to close.

- **Breadcrumb remeasurement**: Breadcrumb dropdown no longer remeasures while open, preventing accidental immediate dismissal.

- **Sync path removal**: Removed scan paths are now propagated to the child sync process and properly skipped.

- **Volume discovery persistence**: Lookup shim is now correctly wired for automatic volume discovery.

- **`cpuBusyPercent=0` fix**: Now correctly means "no throttling" (use all CPUs). Previously behaved incorrectly.

- **`forceRestartSync` orphaning**: Operations now complete immediately to prevent being orphaned on restart.

- **Minimum video duration**: Default `minVideoDurationS` increased to 3.5 seconds to avoid short clips from live videos that browsers can't render.

- **Null tag IDs**: Progress provider now handles null tag IDs without runtime errors.

- **Desktop splash**: Increased retry count from 10 to 20 for improved connection stability during startup.

### 🏗️ Under the hood

- **`@photostructure/sqlite` migration**: Migrated from `better-sqlite3` to `@photostructure/sqlite`, built on Node.js's native `node:sqlite` module. This eliminates the native addon compilation step and reduces startup complexity.

- **SQLite 3.51.2**: Upgraded from 3.49.1 with performance improvements and bug fixes.

- **Sync rebuild consolidated**: Library rebuild went from 5 phases to 3. The separate `reaggregateAsset` pass was merged into `validateAssetSiblings` using a "dissolve" pattern — duplicate assets orphan their files for re-adoption instead of stealing files from other assets.

- **Push-based sync events**: Internal sync-to-web communication now uses JSON Lines over TCP (`SyncEventServer`) instead of polling, reducing latency for live feed updates.

- **`resyncDirectory` RPC removed**: Directory resync is now handled via `forceSyncPath` operations written to the database, replacing the old direct RPC call.

- **AssetFileHash rename**: The `Vec0` virtual table and related code were renamed to `AssetFileHash` for clarity. Added `capturedAtLocal` and `capturedAtFuzzy` metadata columns for filtering during KNN queries.

- **Task serialization reduced**: Removed basename and capturedAt locks from `LockNames`, significantly reducing unnecessary task serialization during sync.

- **`repairAsset` fire-and-forget**: Fixes priority inversion where sub-tasks could be starved when the queue was full of other work.

- **SSE reconnection**: Sync client reconnects after shutdown; dead subscriptions are cleaned up.

- **Raw tags on workers**: `_readRawTags` now runs on worker processes instead of locally, improving sync throughput.

- **Clustering logic**: Updated to compare against all cluster members, enhancing transitive clustering correctness.

- **Camera metadata**: Updated image dimensions for Canon EOS R5 Mark II and Sony ZV-E10 II.

### 📦 Packaging changes

v2026.1.0-beta was an Alpine-based Docker image. To simplify maintenance and improve compatibility, PhotoStructure for Docker is now based on Debian Bookworm-slim. The new image also now includes a static build of ffmpeg v8.0.1 (debian's old ffmpeg was a driver for switching to Alpine).

---

## v2026.1.0-beta - Released January 18, 2026

### ⚠️ Breaking changes

#### 🗄️ Database schema v3 migration

This release includes a database schema migration (v2 to v3). The migration runs automatically on first launch and includes:

- New `DirUri` table for normalized directory storage (reduces database size)
- New `TagHierarchy` table for faster tag tree queries
- New `RejectedFile` table for tracking why files were skipped
- Removal of dominant color columns (`mode0`-`mode6`) from `AssetFile` table

**Note**: Dominant color extraction has been removed from asset aggregation. The feature added complexity without sufficient benefit for asset matching, and the color similarity search was rarely used.

#### 🔨 CLI argument renamed: `--init` (formerly `--write-settings`)

The `--write-settings` CLI argument has been renamed to `--init`. Update any scripts that use this flag.

#### 🍎 Upgraded to Node.js v24 LTS

PhotoStructure now requires Node.js v24.x LTS. Node.js v21.x and v22.x are [end of life](https://github.com/nodejs/Release).

#### 🛣️ Simplified PATH settings

PhotoStructure now uses just the `$PATH` environment variable and the (optional) `PS_TOOLS_PATH` setting to find external tools. Individual tool path settings (`ffmpegPath`, `dcraw_emuPath`, `heifConvertPath`) have been removed. [Read more on Discord.](https://discord.com/channels/818905168107012097/1225106697362604032/1225224946754519062)

#### 🎬 Video encoding migrated to CRF

Video transcoding settings have migrated from bitrate-based to CRF-based (Constant Rate Factor) encoding. CRF provides more consistent quality across different video content. If you had custom `videoBitrate` settings, configure the new `transcodeCrf` setting instead.

### ✨ New features

#### 🔧 New `fix` tool

For server editions, the new `photostructure fix` command runs maintenance and validation jobs:

- `fix --tags`: Validate tags, rebuild search index, recount assets
- `fix --db`: Run VACUUM, ANALYZE, and integrity checks (auto-repairs if corruption detected)
- `fix --db-backup`: Create a backup of the library database
- `fix --cleanup`: Kill orphaned processes, remove stale files

#### 🔄 Automatic re-application of asset file filters

PhotoStructure now tracks a hash of all `Filters` settings. When filter settings change, affected files are automatically re-evaluated during the next sync. This ensures your library stays consistent when you adjust file inclusion/exclusion rules.

#### 🖼️ Tag gallery improvements

- **Child tag dropdown**: New dropdown in the tag gallery header showing all direct child tags for quick navigation
- **Thumb row controls**: New `+/-` buttons to [control how many rows of thumbnails to show](https://forum.photostructure.com/t/support-choosing-the-number-of-displayed-thumbnails/487)

#### 🗺️ Enhanced geotagger with county support

Added "county" support for geographic tagging to help discriminate between [same-named cities](https://discord.com/channels/818905168107012097/1218392684302172170). The default `tagGeoTemplate` is now `["Country","State","County","City"]`. To restore the prior format, set `tagGeoTemplate=["Country","State","City"]` in your library's `settings.toml`.

#### 📁 Directory-level sidecar support

PhotoStructure now looks for `album.xmp` and `metadata.xmp` files in each directory and applies their metadata as low-priority sidecars to all files in that directory. See the `directorySidecars` setting for details. Note: filenames are case-sensitive and sidecars are not inherited by child directories.

#### 🏷️ Separate keyword delimiter for pathname extraction

New `keywordDashDashDelimiters` setting for filename "dash-dash" keyword extraction. This lets you retain whitespace for multi-word keywords (like `/photos/--/Places|United Kingdom/P437289.JPG`). The `keywordDelimiters` setting now only applies to metadata-encoded tags.

### 🎞️ Video transcoding improvements

#### ⚡ Optimized transcoding pipeline

PhotoStructure now analyzes codec/container compatibility to choose the fastest transcoding strategy:

- **Remux** (lossless, seconds): When codecs are browser-compatible but container isn't (e.g., MKV with H.264+AAC to MP4)
- **Audio-only**: When video is compatible but audio needs transcoding (e.g., MTS with H.264+AC-3)
- **Video-only**: When audio is compatible but video needs transcoding
- **Full**: Only when both streams need re-encoding

This can reduce transcode time from minutes to seconds for compatible content.

#### 🌈 Automatic colorspace handling

Video transcoding now detects and correctly handles colorspace metadata:

- HDR content (BT.2020/PQ/HLG) is preserved without conversion
- BT.709 (HD) content is tagged correctly
- BT.601 (SD) content is converted to BT.709 for consistent browser playback
- Unknown metadata uses height-based heuristics

#### 📹 HEVC/H.265 output by default

Transcoded videos now use libx265 (CRF 28) for 25-40% smaller files vs H.264. Configure with `transcodeVideoCodec` and `transcodeCrf` settings.

#### 🔍 Improved codec detection

MKV and MTS containers now correctly detect codecs via ffprobe fallback when ExifTool metadata is incomplete.

### 🎯 Other improvements

#### 📸 Image and media processing

- **ffprobe integration**: Video metadata is now enriched by `ffprobe` (if installed), providing per-stream metadata and supporting many more video formats than ExifTool alone
- **HEIF/HEIC thumbnail optimization**: Thumbnails are now generated by `heif-thumbnailer` (if available), rendering in 10-100ms instead of 2-8 seconds with `heif-convert`
- **ImageDataHash aggregation**: ExifTool's [ImageDataHash](https://exiftool.org/ExifTool.html#ImageHashType) is now used to ensure assets differing only in metadata get correctly grouped together. See the `imageDataHashType` setting

#### 🌐 Platform support

- Added support for Ubuntu 24.04
- Improved soft-delete (trash) support on all platforms, with proper Docker support. [Read about Docker configuration](/server/photostructure-for-docker/#soft-delete-support)

#### ⚙️ New settings

- `fileSizeEpsilon` / `mtimeMsEpsilon`: Control how `sync` detects changed files
- `exactFitResolutions`: Ensure previews fit within specific resolutions (useful for Chromecast)
- `logRetention`: Configure automatic log file cleanup
- `sessionTimeout`: Control web UI session duration
- `dbWalAutoCheckpointPages`: Advanced SQLite WAL checkpoint tuning
- `rejectedFileCacheThresholdMs`: Performance tuning for rejected file caching

#### 🏥 Health check improvements

- Added `$TZ`, `$PUID`, and `$PGID` to environment variable health checks (Docker)
- Added shutdown link from the health page for graceful shutdown when library is unhealthy
- New file watcher health check with platform-specific limits
- Improved OS & CPU architecture detection

### 🐛 Bug fixes

- **ISO token in `assetPathnameFormat`**: Fixed file copies failing when filenames included `:` from ISO timestamps. The default `ISO` token now uses `yyyy-MM-dd'T'HH-mm-ss.SSS`, and invalid filename characters are replaced with `_`
- **`PS_FORCE_LOCAL_DB_REPLICA`**: Fixed setting being ignored in some situations
- **UNIQUE constraint on AssetFile**: Fixed [`UNIQUE constraint failed: AssetFile`](https://discord.com/channels/818905168107012097/818907922767544340/1229863850476568707) errors, including support for in-place URI upgrades to `pslib:` and `psfile:` schemes
- **Health check timeouts**: Fixed spurious failures from incorrect timeout closure boundaries
- **SQLite fts5 integrity**: Upgraded SQLite (now 3.51.1) which fixes a regression where `fts5` indexes could cause integrity checks to fail
- **Asset visibility in sync**: Sync now verifies that an [asset is marked as "shown"](https://discord.com/channels/818905168107012097/818907922767544340/1222232392987578540) before skipping re-processing
- **Duplicate `#id` attributes**: Fixed duplicate HTML IDs on the settings page

### 🏗️ Under the hood

#### 📦 PhotoStructure for Node improvements

- **New bootstrap system**: Replaced shell-based `start.sh` with `bootstrap.js` for more reliable upgrades. Both `./start.sh` and `./photostructure` now work identically
- **`--reinstall` flag**: Pass to `./photostructure` to re-download and recompile third-party libraries
- **macOS Homebrew fix**: Automatically runs `brew install -q python-setuptools` when needed to [solve installation issues](https://forum.photostructure.com/t/trying-to-install-node-on-mac-m1-14-2-1/2166)

#### 🔐 Simplified .env support

PhotoStructure now reads from `/.psenv`, `$HOME/.psenv`, and `$PS_ENV_FILE` with simple key=value parsing. No more conditionals, variable expansion, or `export` required. Last value wins. [See documentation](/go/psenv).

#### 🔧 Other technical changes

- **platform-folders replacement**: Native dependency replaced with equivalent TypeScript
- **Tag gallery PRNG**: New random number generator validated with [dieharder](https://webhome.phy.duke.edu/~rgb/General/dieharder.php), with faster SQL `ORDER BY` and shorter seeds
- **`renice()` behavior**: No-op when `PS_PROCESS_PRIORITY=NORMAL`
- **In-memory task queue**: Task management moved from database table to memory, simplifying code and improving performance
- **JSON de-cycling**: New custom format that doesn't require `eval`
- **POSIX uid/gid handling**: Properly handles platforms without numeric user/group IDs (Windows)
- **`PS_LOG_LEVEL` token format**: Now supports `[TOKEN:]LEVEL,...` for context-specific log levels
- **`PS_OPT_OUT` / `PS_NO_NETWORK`**: Either setting now disables the version health check
- **`PS_AUTO_UPGRADE_SETTINGS`**: Set to `false` to disable automatic settings.toml upgrades
- **`volumeUuidFilePaths` change**: Removed `System Volume Information/IndexerVolumeGuid` from defaults (requires admin privileges on Windows)
- **defaults.env cleanup**: No longer suggests camelCased versions of transient settings
- **fs-extra removal**: Migrated to native `node:fs` APIs
- **Ubuntu 20.04 compatibility**: Rebuilt linux-x64 and linux-arm64 tools to fix libc errors
- **Improved emoji**: Better [emoji](https://discord.com/channels/818905168107012097/818905168690413611/1221567066004390078) for "Share basic installation information?"

### 🐳 PhotoStructure for Docker

- **Updated to Node.js v24 LTS** (bookworm-slim base image)
- **SQLite 3.51.1**: Latest SQLite with performance improvements and bug fixes
- **LibRaw 0.22**: Updated RAW image processing library with new camera support
- `$PS_LIBRARY_DIR` and `$PS_CONFIG_DIR` respected when determining default `$PUID` and `$PGID`
- `$PUID` / `$PGID` respected when spawning shells into containers
- Set `$PS_NO_PUID_CHOWN=1` to skip `chown` calls on library files

## Prior release notes

- [**Release notes from 2025**](/about/2025-release-notes) (no releases)

- [**Release notes from 2024**](/about/2024-release-notes)

- [**Release notes from 2023**](/about/2023-release-notes)

- [**Release notes from 2022**](/about/2022-release-notes)

- [**Release notes from 2021**](/about/2021-release-notes)

- [**Release notes from 2020**](/about/2020-release-notes)

- [**Release notes from 2019**](/about/2019-release-notes)

</div>
