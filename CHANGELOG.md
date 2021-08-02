
This is a detailed list of changes per version.

- Releases sometimes have separate posts that describe new features, like for
  [version 0.6](https://photostructure.com/about/v-0-6/), [version 0.8](https://photostructure.com/about/v-0-8/), and [version
  0.9](https://photostructure.com/about/v-0-9/)).

- Visit [**what's next**](https://photostructure.com/about/whats-next/) to get a sneak peak into what
  we're going to be working on next.

## Please note

- **Stable, released versions are recommended.**

- See [Alpha, beta, stable, and latest; What should you
  use?](https://forum.photostructure.com/t/alpha-beta-stable-and-latest-what-should-you-use/274)
  for more information.

- "Pre-release" builds (those that end with `alpha` or `beta`) have not been
  thoroughly tested, and may not even launch.

- Only run `alpha` or `beta` builds if you have [recent
  backups](https://photostructure.com/faq/how-do-i-safely-store-files/).

- If you update to an alpha or beta build and you want to downgrade to a prior
  version, know that older versions of PhotoStructure may not be able to open
  libraries created by newer versions of PhotoStructure. You will probably need
  to [restore your library from a database
  backup](https://photostructure.com/faq/restore-db-from-backup/).

<!-- TODO: -->
<!-- - ✨/🐛/📦/🚫☠ For most cases, PhotoStructure no longer "fails fast." [Read more here](https://forum.photostructure.com/t/disable-photostructure-from-failing-fast/501). -->
<!-- - ✨ Logs are now viewable in the UI -->

<a id="v1.0.0"></a>

## v1.0.0-beta.13

**2021-08-01**

- 🐛 Fix sorting to be reverse chronological order for child asset galleries (prior builds had inadvertently changed order of child assets to chronological order). Thanks for the report, `mariomare22`!

- 🐛 Prior versions of macOS volume parsing would completely ignore `quarantine` and `nobrowse` mountpoints, but this would cause PhotoStructure to have an incomplete and incorrect view of volumes, leading to invalid Asset File URIs.

- 🐛 Windows upgrades after beta.13 [should restart automatically](https://forum.photostructure.com/t/beta-12-windows-desktop-didnt-restart/822).

- 🐛 Simplify `sync` to check every hour for pending volumes to sync.

- 🐛 Free disk space now uses `realpath` to ensure symlinks and crossmounts (common in macOS) look at the correct volume.

- 🐛 Duplicate mountpoint volumes from `GVFS` and `df` are now merged

- 📦 `copyToLibraryMimetypes`: support for selective automatic organization (say, to only copy raw images into your library). When "automatic organization" is enabled, files whose mimetypes are included in this list will be copied into your originals directory.Note that mimetypes can include an asterisk to do glob-matching. See the related system setting "copyAssetsToLibrary". Defaults to `["image/*", "video/*"]`.

- 📦 `matchSidecarsFuzzily`: set to `false` to disable [fuzzy sidecar matching](https://forum.photostructure.com/t/incorrect-tags-assigned/842/6?u=mrm). If set to true, PhotoStructure will look for sidecar files that match the basename of the asset, plus some common suffixes (like "-edit", "-edited", or variant copies, like "-2"). This setting only impacts .XMP, .MIE, and .EXIF sidecars. PhotoStructure always matches .JSON files fuzzily, as that is required to handle Google Takeouts properly. Defaults to `false` (to be conservative with sidecar matching).

- 📦 Suggested library directory improvements

  - Root mountpoints and direct child directories are checked for prior libraries
  - Suggested directories are verified that they should be read/writable
  - `info --suggested-libraries` exposes these volumes on the command line now.

- 📦 New `siblingInferenceBasenameCoeff` setting controls siblingInferenceBasenameCoeff

- 📦 Volume metadata is now automatically cached for up to a day, based on the amount of free disk space is available. [Thanks for the suggestion, Rodger!](https://forum.photostructure.com/t/1-0-0-beta-2-error-failed-to-scan-system-volumes/581/25?u=mrm). Use `info --volumes-ttl --debug` to see what PhotoStructure thinks.

- 🐛/📦 `volumes()` and `mountpoints()` results are now cached, so if the OS times out or a disk is flaky, the prior successful result will be returned (instead of crashing).

- 🐛/📦 Timezone improvements

  - check for `.tz` and `ExifDateTime` fields in self and siblings
  - prevent the current TZ from “leaking” into unspecified captured-at times
  - respect `enableSiblingInference`
  - when inferred, the `capturedAt.src` now contains information about where the timezone came from

- 📦 New `debugTimeouts` setting which logs debug information whenever any operation times out. Defaults to false.

## v1.0.0-beta.12

**2021-07-20**

- ✨ Slow directories (those that don't `readdir` in less than `readdirCacheSlowMs`) are now automatically excluded from tag inference to prevent `sync` from bogging down on slow/huge directories.

- ✨ Tag inference can now be completely disabled with the new setting, `enableSiblingInference=false`.

- 🐛 beta.10 didn't properly migrate `libraryPath`, and for docker users, the prior behavior defaulted writing settings directly into `/ps/config`, but [beta.10/11 wanted to write to `/ps/config/PhotoStructure`](https://forum.photostructure.com/t/v1-0-0-beta-10-and-v1-0-0-beta-11-released/806/16?u=mrm), which resulted in people [unexpectedly seeing the welcome page](https://forum.photostructure.com/t/v1-0-0-beta-10-and-v1-0-0-beta-11-released/806/9?u=mrm) or `Error: code ENOENT: ENOENT: no such file or directory, open '/ps/config/PhotoStructure/settings.toml'`. The old and new configuration directories will be automatically merged the first time beta.12 runs.

- 🐛 [Lifted droopy traffic lights on macOS](https://forum.photostructure.com/t/v1-0-0-beta-10-and-v1-0-0-beta-11-released/806/6?u=mrm)

- 📦 macOS now has `/opt/homebrew/bin` and `/opt/homebrew/sbin` added to the `toolPaths` setting default.

- 📦 `minDiskFreeGb` can now be set to 0 to [disable free disk space health checks](https://forum.photostructure.com/t/photostructure-stuck-at-processing/538/14?u=mrm).

- 📦 Large library databases will automatically increase `maxMemoryMb` and `maxRssMemoryMb` values to accommodate larger SQLite caches. If non-default values have been set by the user, though, they will be respected.

- 📦 Upgraded all outdated dependencies, including SQLite [3.36.0](https://sqlite.org/releaselog/3_36_0.html)

## v1.0.0-beta.11

**2021-07-14**

- 🐛 [Fixed "Cannot set service name twice" error on launch](https://forum.photostructure.com/t/v1-0-0-beta-10-released/806/3?u=mrm)

## v1.0.0-beta.10

**2021-07-14**

- ✨ Added `validationErrorAllowlist` to fix false-positive JPEG validation errors from smartphone photos that aren't correctly encoded

- ✨ Long tag hierarchies [automatically collapse in tag gallery views](https://forum.photostructure.com/t/volume-id-shows-as-a-tag/754/6?u=mrm).

- ✨/🐛 Volume metadata is now multithreaded to scale to systems that have many attached drives and very slow network drives. [See the forum for details](https://forum.photostructure.com/t/support-for-systems-with-many-external-drives/595).

- ✨/🐛 MacOS and Windows users with tons of volumes: UUID extraction is now done in parallel, which should [avoid "Failed to scan system volumes" errors](https://forum.photostructure.com/t/1-0-0-beta-2-error-failed-to-scan-system-volumes/581).

- ✨ Added new keyword re-parenting setting, [`keywordReparenting`](https://forum.photostructure.com/t/prefix-for-keywords-tag/499)

- ✨ Image hashing performance has been doubled (!!) thanks to [in-memory binary preview extraction](https://github.com/photostructure/exiftool-vendored.js/issues/99#issuecomment-875230809).

- 🐛/📦 Process handling was rebuilt

  - Asset importing rejection reasons are no longer "errors," which caused the `sync-file` process to be recycled (and slow down the import)
  - Health checks are now automatically run, separate from file importing. Unhealthy processes could result in files being skipped in prior builds.
  - Raw image and video importing are now more reliable. Previous implementations would make a go/no-go decision based on the first buffer seen on stderr output--but ffmpeg streams warnings and errors throughout the processing of a video, so this go/no-go was based on incomplete data.

- 🐛 Added another swing at [fixing file access errors on Desktop on macOS](https://forum.photostructure.com/t/apple-photos-database-import-sync/121/3?u=mrm) by calling `scandir` against the library, user directories, and scan paths from the main process.

- 🐛 `sync` [didn't idle in beta.9](https://forum.photostructure.com/t/1-0-0-beta-9-is-ready/693/2).

- 🐛 `startPaused` now holds true [for new libraries](https://forum.photostructure.com/t/docker-environmental-flags-not-working-or-possible-syntax-error/684).

- 🐛 Tag counts were incorrectly cached, which could [prevent new libraries from showing tag counts properly](https://forum.photostructure.com/t/crash-on-initial-scan/727/4).

- 🐛 Improved docker mountpoint filtering (scans could get "stuck" in `/proc/*` volumes)

- 🐛 Remote MacOS AFP volume hostnames are now properly parsed.

- 🐛/📦 Nav menu improvements on mobile: more reliable scrolling on iOS Safari, and the bottom element should now be visible (even when the bottom button bar is shown)

- 🐛 Filepath tags [don't show volume SHAs anymore](https://forum.photostructure.com/t/volume-id-shows-as-a-tag/754)

- 🐛 File paths in the Asset Info panel [could have rendering issues](https://forum.photostructure.com/t/image-filepath-not-correct-synology-docker-compose-alpha-branch/545/4)

- 🐛 `opened-by` lockfiles from prior versions are automatically cleaned up (to avoid [these errors](https://forum.photostructure.com/t/upgraded-to-alpha-photostructure-wont-start/406))

- 🐛/📦 macOS Big Sur versions are now rendered properly on m1 machines

- ✨/📦 The `strictDeduping` setting now automatically sets 9 deduping settings to "very strict" values.

- ✨/📦 Root filesystem tags are now configurable. See the new `tagDisplayNameFSLabels` and `tagDisplayNameFSRoot` settings.

- 📦 Fixed the [progress caret](https://forum.photostructure.com/t/details-arrow-suggestion/386)

- 📦 Fixed the nav menu pointer (thanks, Cowherd!)

- 📦 Improved [asset deduping when pairs have different captured-at precision](https://forum.photostructure.com/t/duplicates-of-photos/749)

- 📦 `--force` now re-transcodes videos (handy for benchmarking `ffmpegHwaccel`)

- 📦 `--no-filter` now disables all filters (including `NoMedia`)

- 📦 The server dockerfile no longer specifies `VOLUME`s

- 📦 Changed the default for `ffmpegHwaccel` from `auto` to `disabled`. Docs suggested that `auto` would be safe, but in practice some platforms (like macOS) throw errors. Feel free to try it out on your box, but don't be surprised when it doesn't work... 😞 (see [this forum post](https://forum.photostructure.com/t/hwaccel-auto-errors-on-docker/735))

- 📦 The config, library, and cache dir now remove rwX from Group and Other to help with security.

- 📦 `main` now runs health checks on the `web` service every minute, and the `sync` service every 15 minutes, just to reduce system load.

- 📦 `maxSyncFileJobs` and `sharpThreadsPerJob` can be overridden (if `cpuLoadPercent` doesn't do what you want).

- 📦 `.cache` directory cleanup is more efficient now (the prior implementation could get "stuck" if concurrent writes happened during `sync`)

- ✨/📦 `logcat` now reads from stdin when no filenames are provided.

- 📦 The `libraryPath`/`PS_LIBRARY_PATH` setting has been renamed `libraryDir`/`PS_LIBRARY_DIR`. This matches all other directory settings. An alias was added for backward compatibility.

- 📦 Added new `remoteFilesystemTypes` that defaults to `sshfs` and `s3fs` (note that non-FUSE filesystems are already handled properly)

## v1.0.0-beta.9

**2021-06-17**

- ✨/🐛 Fixed a race condition in child process handling affecting videos and raw images that could cause these files to not be imported.

## v1.0.0-beta.8

**2021-06-17**

- ✨ Added new `disableAllFilters` setting, that forces all filter settings to their most permissive value.

- ✨ Added new `ffmpegHwaccel` setting enabling [FFmpeg hardware-accelerated transcoding](https://forum.photostructure.com/t/hardware-accelerated-encoding-transcoding/166).

- ✨ Transcoded videos now support [high gamut output](https://forum.photostructure.com/t/poor-transcoding-of-videos-in-wider-color-spaces-rec-2020/646).

- ✨ Added several new date parsers, new `extraDateTimeFormats` defaults, and `CreationTime` to `capturedAtTags`.

* 🐛 Fixed paging for tags with [large numbers of the exact same captured-at time](https://forum.photostructure.com/t/thumbnails-missing-server-install/675/16?u=mrm)

* 🚅/🐛 Updated the is-this-file-in-sync test to handle remote filesystem timestamp skew. This should also help speed up re-syncs of existing volumes.

* 🐛 Full-text search indexes and asset tag counts are now only rebuilt when changed. This should remove the high I/O issue and help with [slow rebuilds](https://forum.photostructure.com/t/slow-stalled-rebuild/640).

* 📦 "Send recent logs" was removed from the nav menu (context was frequently insufficient, and new versions of sentry broke the prior implementation)

* 📦 Upgraded all dependencies, including electron 13.

## v1.0.0-beta.7

**2021-06-14**

- 🐛 [Fixed search result rendering issue](https://forum.photostructure.com/t/search-is-broken-in-beta-5-for-node-and-beta-4-for-mac/673)

## v1.0.0-beta.6

**2021-06-14**

- 🐛 [Fixed tool binary mismatch in docker](https://forum.photostructure.com/t/bug-too-few-pictures-imported/672) which prevented JPEGs from being imported

## v1.0.0-beta.5

**2021-06-08**

- 🐛 [Fixed asset info panel dropdowns](https://forum.photostructure.com/t/1-0-0-beta-4-is-ready/647/10?u=mrm)

## v1.0.0-beta.4

**2021-06-08**

- ✨ [Video assets in galleries now show a duration](https://forum.photostructure.com/t/show-video-icon-and-or-video-duriation-in-video-thumbnails/94) (the video icon wasn't added in an effort to reduce the number of DOM elements on the page and get Firefox to render faster)

- ✨ Tag gallery thumbnails now have a captured-at `title` (hover over photos to
  see when they were taken).

- ✨ [JSON Takeout sidecars for images ending in `-edited` or `-1`](https://forum.photostructure.com/t/creation-time-formatted-time-total-confusion-or-google-takeout-sidecar-files-are-misnamed/574/16) are now paired properly.

- ✨ Better crash recovery: irreparable SQLite replicas found in the cache directory are now replaced with the primary database automatically.

- 🚅/📦 Tag asset counts in prior versions were updated monolithically (every tag's asset count was recomputed every 5 minutes during syncs). This approach is reasonably fast for smaller libraries, but for larger (200k+ asset files) libraries (especially not stored on SSDs), these queries could take > 30 seconds, which had a large performance impact on filesystem synchronization.

  Tag asset counts are now updated incrementally, and the update query itself has been improved as well (even with very large libraries, incremental tag counts take under 1 second with the new code).

- 🚅/📦 Images on all browsers [that aren't Safari](https://caniuse.com/loading-lazy-attr) now use [lazy loading](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img#attr-loading). This helps improve the page load time on full-screen 4k displays, but Chrome is still instantaneous, and Firefox takes seconds (at least on Linux).

- ✨/📦 [De-duplication improvement](https://forum.photostructure.com/t/combining-images/524/14?u=mrm) by adding `MetadataDate` to the default set of captured-at tags.

- 🐛 Restored [PhotoStructure's periodic sync job](https://forum.photostructure.com/t/does-photostructure-stay-in-sync-with-filesystem-changes/280)

- 🐛 Docker [license validation errors](https://forum.photostructure.com/t/error-during-initial-license-validation/620) and should be fixed now. Apologies if you saw this!

- 🐛 PhotoStructure no longer looks for sidecar metadata for files within `.photostucture` directories

- 🐛 Gallery rendering has been improved for mobile displays, which in prior versions sometimes showed blank grey rectangles at the bottom right.

- 📦 SQLite backups now try to use [the backup API](https://sqlite.org/backup.html), and if that fails, tries the new [`VACCUM INTO` command](https://sqlite.org/lang_vacuum.html#vacuuminto).

- 📦 Docker users: A `UMASK` environment variable, if set, will be given to `umask` during startup. The default is `0022` which removes "group" and "other" write permissions. You may want a more restrictive `0027` which removes read access to "other".

## v1.0.0-beta.3

**2021-05-20**

- ✨ PhotoStructure now imports [invalidly-named UUID-like JSON sidecars from Google Takeouts](https://forum.photostructure.com/t/creation-time-formatted-time-total-confusion-or-google-takeout-sidecar-files-are-misnamed/574)

- ✨ PhotoStructure for Desktop's splash screen now renders both the version and startup progress.

- ✨ Date parsing now uses a customizable set of datetime formats. See the new `extraDateTimeFormats` setting for more information.

  If you have an old LG phone, you might want to add `MM.dd.yyyy HH:mm:ss` to this setting (I didn't/couldn't add this to the default list, as the format ambiguously defines MDY and DMY, and ambiguous parsing leads to pain and suffering).

- 🐛 On initial library scan, a "library is empty" message would be rendered due to incorrect asset-count caching. This has been fixed.

- 🐛 Fixed the ["update now..." menu item which could result in breaking the current installation](https://forum.photostructure.com/t/remove-update-now-option-when-already-updated/597).

- 🐛/📦 Computers in "dark mode" could obscure parts of the PhotoStructure <span class="plus">plus</span> checkout page and the email with the verification code. We now explicitly set the background color to fix this issue.

- 🐛/📦 Both environment and file settings can now use either `PS_SHOUTY_SNAKE_CASE` or `camelCase` names of settings, (like `PS_LOG_LEVEL` and `logLevel`) in an effort to make things "just work." We recommend `PS_SHOUTY_SNAKE_CASE` for environment variables, though, just to avoid PhotoStructure settings from colliding with any other software.

- 🐛/📦 The [`info` tool](https://photostructure.com/server/tools/) now has a working `--filter` argument to filter output to only fields you're interested in

- 📦 Logfiles now automatically rotate every day

- 📦 As part of PhotoStructure's "health checks," it verifies that a library volume can be written to. These "write tests" are called `.tmp-XXXXX/write-test.jpg` and live in your originals directory. [In some cases these may be created but not successfully deleted](https://forum.photostructure.com/t/what-are-the-tmp-folders/138). PhotoStructure now tries to clean up prior `.tmp-*` directories when performing health checks.

- 📦 PhotoStructure for Desktops now shuts down (rather than running in the background) if the main window is closed and a library hasn't been set up yet.

- 📦 PhotoStructure for Desktops fills the screen on 1080p displays. On larger displays, it only takes 80% of the screen.

- 📦 Upgraded all dependencies, which included updates to sharp, electron, and knex

- 📦 PhotoStructure for Desktops is now being signed by an extended-verification code signing certificate from Sectigo. Prior releases were signed with a certificate from DigiCert. This _should_ be a transparent change.

## v1.0.0-beta.2

**2021-05-07**

- 🐛/📦 PhotoStructure for Node's `start.sh` now works under [`bash`](https://www.gnu.org/software/bash/), [Cygwin](https://www.cygwin.com/), and from [Git for Windows](https://gitforwindows.org/)

- 📦 Timeouts are now configurable (because _what PhotoStructure really needed was MOAR SETTINGS_). The defaults are the same as before, but those of you with 10+ external volumes or (very eh, lethargic?) HDDs can now double or triple these timeouts.

## v1.0.0-beta.1

**2021-05-05**

- ✨ Added a first pass at tag normalization: the "Album", "Keyword" and "Who" tags now all support "aliases", controlled by the new `rootTagAlbumsAliases`, `rootTagKeywordsAliases`, and `rootTagWhoAliases` settings. This helps normalize tags in existing files, say, if your keywords aren't (all) in English, or have inconsistencies ("Keyword/Sky" and "Keyword**s**/Sky").

- ✨ Dropdown menu improvements

  - 📦 Dropdown menus are now positioned to [ensure the content is visible](https://forum.photostructure.com/t/download-dropdown-not-completely-viewable-synology-docker-compose-alpha-branch/546). If possible, they show to the right and below the click target, but will render to the left or even above the click target if the right or bottom screen edge is close.
  - 📦 Dropdown menus now have a close button.
  - 📦 Dropdown menus can now be dismissed by clicking or tapping anywhere else on the screen, and these taps and clicks that dismiss a menu are ignored.
  - 📦 Dropdown menu contents can scroll vertically if their content is too tall for the screen.

- ✨/📦 Improved UID/GID handling for those upgrading PhotoStructure for Docker from v0.9.

  Prior to v1.0, PhotoStructure for Docker defaulted to running as root. To prevent upgrades from failing due to permission issues, we now default the userid to match the current owner of `/ps/config/settings.toml`.

  This default value will be overridden if `UID`, `GID`, `PUID`, or `PGID` are set, which is recommended to minimize both the number of files owned by root, and the number of processes running as root (even within containers).

  If the file is missing, we default to `1000` for both the UID and GID, which
  is the default for the first non-system user (at least in Ubuntu and Fedora).

- 🐛 Fixed PhotoStructure for Desktops packaging: `alpha.7` was [erroneously](https://forum.photostructure.com/t/libvips-cpp-so-42-not-found-on-appimage-upgrade-from-0-9-1-to-1-0-0-alpha-7/542) [omitting](https://forum.photostructure.com/t/cant-launch-latest-photostructure-alpha/561) required third-party `.so`/`.dll`s.

- 🐛 Name parsing for family names that end in "i" is now fixed.

- 🐛 The `when:` and `date:` search query filters are now synonyms, and normalize to `date:` ([details](https://forum.photostructure.com/t/the-search-filters-when-and-date-dont-act-the-same/500)).

- 🐛/📦 Tag paths are normalized to ["NFC" Unicode Normalization Form](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/normalize) now. This should help library portability between macOS and other platforms.

- 🐛 Asset streams are now always scrolled into view on navigation (this was broken in alpha.7)

- 🐛 Navigating from the welcome page to the plans page could take a while if the user had many slow drives. An aggressive timeout (3 seconds) was added to prevent the page from hanging.

- 🐛/📦 The "shown" asset file variant in the asset info panel is easier to select now (the prior click target was only the pathname)

- 🐛/📦 Searching for `before:2022` now works (if you want a query that returns all assets in your library). Previous versions applied the "captured at" validity filter to dates, which reject dates more than several weeks in the future.

- 📦 The `View` menubar items were re-ordered

- 📦 Environment and TOML settings now support "aliases." This allows us to change or improve the names of settings between versions but not break existing configurations. These aliases are listed per setting in the library and system `settings.toml` files now.

- 📦 `settings.toml` and `defaults.env` now enumerate all environment and TOML key aliases (so prior setting names can be found).

- 🐛/📦 Clicking "continue" from `/welcome` now has an aggressive timeout to prevent hangups during the initial installation flow. If you have tons of slow external disks attached to your computer, this should help.

- 🐛 Subscription signups could fail sometimes when the Stripe API reported that newly-created customers didn't exist. We retry these requests automatically now to work around this issue.

- 📦 The `info` tool now supports filtering output, including deep fields. See `info --help` for more information.

- 📦 PhotoStructure for Node's `start.sh` script now

  - 📦 verifies that Node.js is at least v14.16.0
  - 📦 warns if `ffmpeg` isn't available
  - 📦 warns Ubuntu 18 users that HEIF isn't supported

- 📦 Ubuntu 18 fixes:

  - 🐛 `lsblk` parsing supports older versions (that don't support volume size information)

  - 📦 rebuilt binaries on 18.04 (prior alpha builds had binaries built on Ubuntu 20.04)

## v1.0.0-alpha.7

**Released 2021-04-16**

- ✨ The [back button no longer resets scroll position](https://forum.photostructure.com/t/improve-back-button-navigation/206) on tag or search pages!

- 🐛 Docker now disables the bounce service, which should address [this docker crash](https://forum.photostructure.com/t/alpha-is-crashing-occasionally/399)

### Search improvements

- ✨/🐛/📦 Search had been query-as-you-type. Now searches are only executed when the user hits return, clicks the magnifying glass, or taps the "search" key on their mobile keyboard.

- ✨ Search results are now paged via lazy-loaded infinite scroll

- ✨ The search button on non-root tags now pre-fills the search icon with the current tag to support paging through all inherited assets and as a start to adding more search criteria.

- ✨ You can now clear prior searches (there’s an X to the right of the heading)

- 🐛 Fixed the [prior search list](https://forum.photostructure.com/t/prior-searches-list/479)

- 🐛 Query parameters from search no longer transfer when returning to the home page

- 📦 Reworked the search examples

- 📦 Search queries with unmatched quotes, `AND`, or `OR` are no longer considered valid.

- 📦 The search button [isn't hidden on mobile devices anymore](https://forum.photostructure.com/t/dont-hide-search-button-even-for-narrow-screen-size/492).

### Other improvements

- ✨ Keyword extraction is now [more configurable](https://forum.photostructure.com/t/more-settings-to-control-imported-keywords/496)

- 🐛 `docker-entrypoint.sh` now `exec`s `node`, which lets docker shutdown propagate to PhotoStructure, and let it shut down gracefully (and avoid "Library is already opened by" errors)

- 📦 New `openLockStaleMinutes` setting, which defaults to 1 hour: `If an opened-by lockfile has not been touched in this number of minutes, the file is considered stale and invalid. Libraries will refresh their lockfile more frequently than this period. The disk that hosts your library won't be able to idle if this is set too short`

- 📦 `yarn.lock` is now copied into the docker container to ensure consistent contents

- 🐛 `-alpha.1` changed some paths from `PhotoStructure` to `photostructure`. `-alpha.2` reverted several of these changes, but logfiles were still being written to `photostructure`. `-alpha.7` fixes this.

- 📦 Upgraded to [Electron](https://www.electronjs.org/) v12.0.4 and [ExifTool](https://exiftool.org/) v12.24

## v1.0.0-alpha.6

**Released 2021-04-12**

- ✨ Added `meta` headers to [support iOS homescreen](https://forum.photostructure.com/t/ios-homescreen-support/162).

- ✨ Have scanned images of older photos? A new `datesBeforeAreEstimated` setting automatically considers all captured-at times before 1999 to be an "estimated" time, which requires files to have a tighter image correlation to be considered a duplicate of an existing asset variant. [This addresses issues like this](https://forum.photostructure.com/t/why-assetfile-shown-0/473/9?u=mrm).

**PhotoStructure for Desktops:**

- 🐛 Fixed the stripe checkout background

- 🐛 The stripe.com link in the plans page is now clickable

**PhotoStructure for Docker:**

- 🐛 Fixed bogus "PS_LIBRARY_PATH must be set" error in `/settings`

- 📦 If you are seeing file permission problems, temporarily set the environment variable `PS_FIX_PERMISSIONS=1` and run `docker-compose up` (without `--detach`) or `docker run -it photostructure/server:alpha`. This will run `chmod -R $UID:$GID /ps` as root from within docker, so make sure `UID` and `GID` are set appropriately. This `chmod` should address any permission issues if you previously ran a PhotoStructure container as the root user.

- 📦 Set the environment variable `UID=0` if you want to run PhotoStructure as the root user within your docker container, as it has in prior versions.

- 🐛/📦 If either the `/ps/tmp` or `/ps/cache` directories are bind-mounted, either will be used for the cache directory. This should solve spurious EACCES errors that some alpha testers saw.

## v1.0.0-alpha.4

**Released 2021-04-11**

- 🐛 Fix docker ENTRYPOINT and UID/GID handling

- 📦 Docker detection was massaged: PhotoStructure first looks at the `PS_IS_DOCKER` environment variable. If it's set to 0 or 1, it'll use that value. If `PS_IS_DOCKER` is not set, and the OS is Linux, _and_ `/etc/alpine-release` exists, PhotoStructure assumes it's running within docker. Those of you running Alpine outside of docker, please set `PS_IS_DOCKER=0` and please send me an email why you run Alpine.

- 📦 Removed almost all of the `ENV` settings in the `Dockerfile`: `PS_LIBRARY_DIR`, `PS_LOG_DIR`, ... are now given (the same) default values when PhotoStructure sees that it is running within docker.

- 📦 If you start up Docker and are missing some bind mounts, PhotoStructure will now error with a link to the [bind mount volume descriptions](https://photostructure.com/server/photostructure-for-docker/#docker-volume-setup).

## v1.0.0-alpha.3

**Released 2021-04-11**

- ✨ [Search support](https://photostructure.com/faq/search/): one of the [most-requested features](https://forum.photostructure.com/t/asset-search-support/97) 🎉

- ✨ PhotoStructure for Desktop users: [Open in browser...](https://photostructure.com/faq/search/) now opens the current URL in a local browser, rather than the home page.

- ✨ [Extraction support for ACDSee face tags](https://forum.photostructure.com/t/workflow-for-organizing-tagging-my-pictures/438/4?u=mrm)

- ✨ PhotoStructure for Docker users: added [support for UID/GID](https://forum.photostructure.com/t/add-linuxserver-style-puid-and-pgid-support-to-the-photostructure-docker-image/370) (rather than fighting with `userns`).

- 🐛 `settings.toml` files encoded in [UTF-16 (LE) and UTF-8 with a BOM](https://forum.photostructure.com/t/change-subdirectorydatestampformat/455/9?u=mrm) are now read correctly.

- 📦 Added new `writeMetadataToSidecarsIfSidecarExists` setting, whose name is both self-documenting, and a new winner for longest-named setting.

- 📦 Upgraded all dependencies, including electron, sharp, and SQLite

- 📦 Direct (non-sidecar) metadata writes to large files and movies are now [correctly handled](https://forum.photostructure.com/t/manually-editing-capture-time-title-and-description-caption/104/9)

## v1.0.0-alpha.2

**Released 2021-03-19**

- 💔 I've reverted the `UserData` directory downcasing that was changed in
  `-alpha.1`: I believe I've fixed the problem with Electron startup that caused
  this issue. Sorry for the changes!

- ✨ Say hello to `.cr3` support! LibRaw v0.20.1 is now included in all editions
  of PhotoStructure, as Ubuntu and Fedora distros are tracking older versions
  that don't support .cr3.

- ✨ The main PhotoStructure for Desktops binary now supports command-line
  options, so running `PhotoStructure-1.0.0-x86_64.AppImage --verbose` on a
  terminal is now a thing.

- ✨ PhotoStructure for Desktops has a new "Open in browser..." in the View menu
  and the system tray menu.

## v1.0.0-alpha.1

**Released 2021-03-14**

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
