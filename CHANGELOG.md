
<div class="release-notes">

## Next release

### Breaking changes

#### Database schema v3 migration

This release includes a major database schema migration (v2 to v3). The migration runs automatically on first launch and includes:

- New `DirUri` table for normalized directory storage (reduces database size)
- New `TagHierarchy` table for faster tag tree queries
- New `RejectedFile` table for tracking why files were skipped
- Removal of dominant color columns (`mode0`-`mode6`) from `AssetFile` table

**Note**: Dominant color extraction has been removed from asset aggregation. The feature added complexity without sufficient benefit for asset matching, and the color similarity search was rarely used.

#### CLI argument renamed: `--init` (formerly `--write-settings`)

The `--write-settings` CLI argument has been renamed to `--init`. Update any scripts that use this flag.

#### Upgraded to Node.js v24 LTS

PhotoStructure now requires Node.js v24.x LTS. Node.js v21.x and v22.x are [end of life](https://github.com/nodejs/Release).

#### Simplified PATH settings

PhotoStructure now uses just the `$PATH` environment variable and the (optional) `PS_TOOLS_PATH` setting to find external tools. Individual tool path settings (`ffmpegPath`, `dcraw_emuPath`, `heifConvertPath`) have been removed. [Read more on Discord.](https://discord.com/channels/818905168107012097/1225106697362604032/1225224946754519062)

#### Video encoding migrated to CRF

Video transcoding settings have migrated from bitrate-based to CRF-based (Constant Rate Factor) encoding. CRF provides more consistent quality across different video content. If you had custom `videoBitrate` settings, configure the new `transcodeCrf` setting instead.

### New features

#### New `fix` tool

For server editions, the new `photostructure fix` command runs maintenance and validation jobs:

- `fix --tags`: Validate tags, rebuild search index, recount assets
- `fix --db`: Run VACUUM, ANALYZE, and integrity checks (auto-repairs if corruption detected)
- `fix --db-backup`: Create a backup of the library database
- `fix --cleanup`: Kill orphaned processes, remove stale files

#### Automatic re-application of asset file filters

PhotoStructure now tracks a hash of all `Filters` settings. When filter settings change, affected files are automatically re-evaluated during the next sync. This ensures your library stays consistent when you adjust file inclusion/exclusion rules.

#### Tag gallery improvements

- **Child tag dropdown**: New dropdown in the tag gallery header showing all direct child tags for quick navigation
- **Thumb row controls**: New `+/-` buttons to [control how many rows of thumbnails to show](https://forum.photostructure.com/t/support-choosing-the-number-of-displayed-thumbnails/487)

#### Enhanced geotagger with county support

Added "county" support for geographic tagging to help discriminate between [same-named cities](https://discord.com/channels/818905168107012097/1218392684302172170). The default `tagGeoTemplate` is now `["Country","State","County","City"]`. To restore the prior format, set `tagGeoTemplate=["Country","State","City"]` in your library's `settings.toml`.

#### Directory-level sidecar support

PhotoStructure now looks for `album.xmp` and `metadata.xmp` files in each directory and applies their metadata as low-priority sidecars to all files in that directory. See the `directorySidecars` setting for details. Note: filenames are case-sensitive and sidecars are not inherited by child directories.

#### Separate keyword delimiter for pathname extraction

New `keywordDashDashDelimiters` setting for filename "dash-dash" keyword extraction. This lets you retain whitespace for multi-word keywords (like `/photos/--/Places|United Kingdom/P437289.JPG`). The `keywordDelimiters` setting now only applies to metadata-encoded tags.

### Video transcoding improvements

#### Optimized transcoding pipeline

PhotoStructure now analyzes codec/container compatibility to choose the fastest transcoding strategy:

- **Remux** (lossless, seconds): When codecs are browser-compatible but container isn't (e.g., MKV with H.264+AAC to MP4)
- **Audio-only**: When video is compatible but audio needs transcoding (e.g., MTS with H.264+AC-3)
- **Video-only**: When audio is compatible but video needs transcoding
- **Full**: Only when both streams need re-encoding

This can reduce transcode time from minutes to seconds for compatible content.

#### Automatic colorspace handling

Video transcoding now detects and correctly handles colorspace metadata:

- HDR content (BT.2020/PQ/HLG) is preserved without conversion
- BT.709 (HD) content is tagged correctly
- BT.601 (SD) content is converted to BT.709 for consistent browser playback
- Unknown metadata uses height-based heuristics

#### HEVC/H.265 output by default

Transcoded videos now use libx265 (CRF 28) for 25-40% smaller files vs H.264. Configure with `transcodeVideoCodec` and `transcodeCrf` settings.

#### Improved codec detection

MKV and MTS containers now correctly detect codecs via ffprobe fallback when ExifTool metadata is incomplete.

### Other improvements

#### Image and media processing

- **ffprobe integration**: Video metadata is now enriched by `ffprobe` (if installed), providing per-stream metadata and supporting many more video formats than ExifTool alone
- **HEIF/HEIC thumbnail optimization**: Thumbnails are now generated by `heif-thumbnailer` (if available), rendering in 10-100ms instead of 2-8 seconds with `heif-convert`
- **ImageDataHash aggregation**: ExifTool's [ImageDataHash](https://exiftool.org/ExifTool.html#ImageHashType) is now used to ensure assets differing only in metadata get correctly grouped together. See the `imageDataHashType` setting

#### Platform support

- Added support for Ubuntu 24.04
- Improved soft-delete (trash) support on all platforms, with proper Docker support. [Read about Docker configuration](https://photostructure.com/server/photostructure-for-docker/#soft-delete-support)

#### New settings

- `fileSizeEpsilon` / `mtimeMsEpsilon`: Control how `sync` detects changed files
- `exactFitResolutions`: Ensure previews fit within specific resolutions (useful for Chromecast)
- `logRetention`: Configure automatic log file cleanup
- `sessionTimeout`: Control web UI session duration
- `dbWalAutoCheckpointPages`: Advanced SQLite WAL checkpoint tuning
- `rejectedFileCacheThresholdMs`: Performance tuning for rejected file caching

#### Health check improvements

- Added `$TZ`, `$PUID`, and `$PGID` to environment variable health checks (Docker)
- Added shutdown link from the health page for graceful shutdown when library is unhealthy
- New file watcher health check with platform-specific limits
- Improved OS & CPU architecture detection

### Bug fixes

- **ISO token in `assetPathnameFormat`**: Fixed file copies failing when filenames included `:` from ISO timestamps. The default `ISO` token now uses `yyyy-MM-dd'T'HH-mm-ss.SSS`, and invalid filename characters are replaced with `_`
- **`PS_FORCE_LOCAL_DB_REPLICA`**: Fixed setting being ignored in some situations
- **UNIQUE constraint on AssetFile**: Fixed [`UNIQUE constraint failed: AssetFile`](https://discord.com/channels/818905168107012097/818907922767544340/1229863850476568707) errors, including support for in-place URI upgrades to `pslib:` and `psfile:` schemes
- **Health check timeouts**: Fixed spurious failures from incorrect timeout closure boundaries
- **SQLite fts5 integrity**: Upgraded SQLite (now 3.51.1) which fixes a regression where `fts5` indexes could cause integrity checks to fail
- **Asset visibility in sync**: Sync now verifies that an [asset is marked as "shown"](https://discord.com/channels/818905168107012097/818907922767544340/1222232392987578540) before skipping re-processing
- **Duplicate `#id` attributes**: Fixed duplicate HTML IDs on the settings page

### Under the hood

#### PhotoStructure for Node improvements

- **New bootstrap system**: Replaced shell-based `start.sh` with `bootstrap.js` for more reliable upgrades. Both `./start.sh` and `./photostructure` now work identically
- **`--reinstall` flag**: Pass to `./photostructure` to re-download and recompile third-party libraries
- **macOS Homebrew fix**: Automatically runs `brew install -q python-setuptools` when needed to [solve installation issues](https://forum.photostructure.com/t/trying-to-install-node-on-mac-m1-14-2-1/2166)

#### Simplified .env support

PhotoStructure now reads from `/.psenv`, `$HOME/.psenv`, and `$PS_ENV_FILE` with simple key=value parsing. No more conditionals, variable expansion, or `export` required. Last value wins. [See documentation](https://photostructure.com/go/psenv).

#### Other technical changes

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

### PhotoStructure for Docker

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
