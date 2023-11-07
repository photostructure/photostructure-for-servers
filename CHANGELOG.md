
This is a detailed list of changes in each version.

- Major releases have posts summarizing bigger changes. See [the posts tagged with "release notes"](/tags/release-notes/).

- New releases, starting in 2023, use "calendar versioning," or [CalVer](https://calver.org/), using scheme `YYYY.MM.MINOR`.

- **Stable, released versions are recommended.** [See the forum post for details about alpha, beta, and stable releases.](https://forum.photostructure.com/t/alpha-beta-stable-and-latest-what-should-you-use/274)

- "Pre-release" builds (those that include `alpha` or `beta`) have not been thoroughly tested, and may not even launch.

- Only run `alpha` or `beta` builds if you have [recent backups](/faq/how-do-i-safely-store-files/).

- If you update to an alpha or beta build and you want to downgrade to a prior version, know that older versions of PhotoStructure may not be able to open libraries created by newer versions of PhotoStructure. You will probably need to [restore your library from a database backup](/faq/restore-db-from-backup/).

<!-- TODO: -->
<!-- - 🐛 Sync doesn't seem to no-op properly for a completed directory -->
<!-- - 🐛 Tag gallery is not sorted and has too many rows -->

<!-- - ✨ Logs are now viewable in the UI -->
<!-- - 🐛 [Tag reparenting doesn't seem to work properly on rebuilds](https://forum.photostructure.com/t/who-tags-are-incorrectly-excluded-from-keywords/676/6?u=mrm). -->
<!-- - 🐛 Sync resume (after pause) on mac via the menubar (not the main window nav button) doesn't seem to support "resume" properly -->

<!-- fix "tag context" for "next previous" context. I'd always done a search, clicked a thumb, and then clicked esc to go back to the search results. But...  if you click a thumb from a search,  and then click "next" or "previous", it ignores that you can from a search, and does the chronological next asset, which is very confusing/irritating. -->

## v2023.11.0-alpha.1

**To be released**

### 💔/🐛 Exclusion globs have been simplified

- Exclusion glob patterns are now applied both in and out of libraries: the
  `excludeGlobsInLibrary` setting (introduced last build) was confusing, and
  has been deleted.

- The `disableIgnorableFilters` setting was renamed to
  `omitDefaultExcludeGlobs`, but does the same thing: if set to `true`, users
  start with an empty set of exclusion globs, and use `excludeGlobsAdd` to
  build up whatever set of patterns they want.

- See [the discord chat for details](https://discord.com/channels/818905168107012097/1170442569671512245)

### Additional improvements

- 🐛 Video transcodes in prior builds had a 2 minute timeout (due to a
  misapplication of a default argument), which would slow down larger video
  imports because transcode operations would timeout incorrectly and retry
  (causing the system to bog down with the _same_ ffmpeg operation multiple
  times)

- ✨ `ffmpegHwaccel` can now be safely kept at `auto`--PhotoStructure will
  attempt the transcode with `-hwaccel=auto`, but if that fails (due to
  missing hardware support for the necessary codecs, for example), we'll
  automatically re-try that transcode operation without a `-hwaccel` argument.

- 🐛 `Asset.durationMs` is now properly copied from AssetFile variations up to
  Asset. Prior builds could have missing duration timestamps in tag galleries.
  
  Note that this is backfilled partially by a database migration that will be
  applied automatically, as well as a step that invalidates all asset files
  (and assets) that are videos and missing `.durationMs`.

- 🐛 Fixed `./start.sh` warnings and errors related to python `disttools` and
  `setuptools`

- 🐛 Fixed [version health check
  bug](https://discord.com/channels/818905168107012097/818907922767544340/1169801101806145566)
  where running a newer version than what is advertised as being available was
  marked as being "out of date". Also added channel advice if a more stable
  channel is providing a newer release.

- 📦 `./photostructure info --version-check` is now a whole thing, and invalidates prior cache.

- 📦 Open Graph headers were simplified: we now only send one video or image
  entry, using the closest available prerender to `openGraphTargetWidth`.
  Previews seem to work properly now at least on Apple iMessages.
  
- 📦 New `checkBasenameMatches` setting (defaults to true) adds Yet Another
  asset file's existing-asset adoption search strategy. This is a minor
  deduplication improvement, and doesn't seem to adversely impact import
  speed.
  
- 📦 Docker images should now include a proper set of labels

## v2023.11.0-prealpha.19

**Released 2023 November 2**

- 🐛 File hidden tests no longer run on drive letters on windows (`C:\` is reported to be hidden as per `Get-Item`)

- 🐛 Fixed PowerShell health check on Windows

## v2023.11.0-prealpha.18

**Released 2023 November 2**

### ✨ Version checking was added as a health check

PhotoStructure can now make periodic requests to
https://photostructure.com/channel-versions.json, using a
[User-Agent](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent)
that exposes

- The version of PhotoStructure that you're using (`PhotoStructure/2023.10.0`)
- Your operating system and system architecture (like `Windows 11 on x64` or `Ubuntu 22.04.3 LTS on x64`)
- Your current subscription (`PLUS` or `LITE`)

Several new settings were added to let you suit this feature to your taste:

1. A new section in the Settings page lets you disable either the version
   check altogether, or just the custom user agent

1. By setting `PS_AUTO_UPDATE_CHECK=false`, which disables version checks, or

1. By setting `PS_ALLOW_USER_AGENT=false`, which makes the `User-Agent` be
   simply `PhotoStructure`, or

1. By opting out of all external network requests with the new meta-setting,
   `PS_OPT_OUT=true`, which changes:

   - the default value of `PS_AUTO_UPDATE_CHECK` to false
   - the default value of `PS_ALLOW_USER_AGENT` to false, and
   - the default value of `PS_REPORT_ERRORS` to false

   In the future, when there are any other features in the future that may
   require external network requests, those will be disabled by default with
   this meta setting as well.

### Video improvements

- 💔 **VLC support has been dropped.** Please use FFmpeg instead. [Setup
  instructions were updated for every platform.](/video)

- 🐛 Depending on how video files were encoded, metadata (like the video
  duration) could have been missing in prior builds. PhotoStructure now
  properly omits the `-fast` argument when reading and extracting video
  metadata. This bug could have caused videos to not be imported in prior
  builds, or video transcode timeouts to be (very) incorrect.

- 🐛 `ffmpeg` transcode rescaling could fail on older versions, causing videos
  to not be imported. We now try the new-style `-filter:v scale=WIDTH:HEIGHT`
  format, and automatically downgrade to the older style `-s WIDTHxHEIGHT`
  argument format if there are errors. See the new `ffmpegScaleType` setting
  for details:

> What style of resize works for your version of ffmpeg?
>
> - `vf` will use `-vf scale=WxH`
> - `s` will use `-s WxH`.
>
> The default should be fine: only very old versions should use "s".

- 🐛 `ffmpeg` transcoding now supports bounded framerates. See the new
  `transcodeFrameRate` setting for details:

> If set, transcoded videos will be bounded to this framerate. Videos that are
> lower than this framerate will retain their original (lower) framerate.
>
> Note that framerate reduction does not reduce the final transcoded video
> size linearly: it may only reduce file sizes by ~20% to go from 60 FPS to 30
> FPS.
>
> Unset this or set to 0 to disable bounded framerates.

- 🐛 Video timezone parsing has been
  [improved](https://github.com/photostructure/exiftool-vendored.js/issues/156)

### Additional changes and improvements

- ✨ Asset pages are now rendered with OpenGraph header metadata. [See the
  forum for
  details](https://forum.photostructure.com/t/image-thumbnail-in-link-preview/1950/2).

- 🐛 Image rotation was broken for some orientations in prior builds. We now
  only consider rotations that match the exemplar aspect ratio. The final
  rotation formula was simplified and (more) tests were added as well.

- 🐛 `sync` re-scheduling in prior prealpha builds would only happen if
  mountpoints had changed--now there is no such prerequisite condition.

- 🐛 Very large values of `PS_MAX_MEMORY_MB` will no longer result in [very
  few worker
  processes](https://discord.com/channels/818905168107012097/1152796699912310794).

- 🐛 More recent Panasonic camera RAW images can now be imported by
  PhotoStructure, with the addition of the new `validateMimetypeSkiplist`
  setting, and adding `JpgFromRaw2` to the default set of the
  `embeddedPreviews` setting.

- 🐛 PhotoStructure tried to look at Linux `cgroup` files for CPU scheduling,
  but the implementation proved to be incorrect on many systems.
  PhotoStructure now relies on
  [availableParallelism](https://nodejs.org/dist/latest-v18.x/docs/api/os.html#osavailableparallelism).
  If that isn't available, PhotoStructure counts the CPUs returned by
  [os.cpus()](https://nodejs.org/dist/latest-v18.x/docs/api/os.html#oscpus).
  See the [forum post for more
  details](https://forum.photostructure.com/t/no-sync-on-synology-docker/1959/11?u=mrm)
  (thanks for the assist, @underdog!)

- 🐛 The `assetPathnameFormat` setting in prior builds was stripped of **all**
  quotes, which resulted in static strings incorrectly being interpreted as
  path tokens.

- 📦 Thumbnail and video serving by the web service is now more tolerant of
  incorrect/unavailable resolutions: PhotoStructure will 302-redirect to the
  nearest resolution preview now.

- 📦 `PS_LOG_SERVER_LEVEL` now defaults to the value of `PS_LOG_LEVEL` if unset.

- 📦 Added version extraction backstop for Debian/Ubuntu external tooling
  (mostly for `heif-convert` debugging).

- 📦 PhotoStructure can now use `dpkg -S` to check for installed versions of
  tools on Debian-based systems (which will help debug issues with `ffmpeg`
  and `heif-convert`).

- 📦 EXIF dates can be partially specified--month and day that is set to two
  spaces is considered "unset", so "2023: : " or "2023:00:00" is considered
  to just be the year 2023. [See the forum for
  details](https://forum.photostructure.com/t/340/19).

- 📦 Timezone offsets (like "+5" or "-07:00") are now optionally extracted and
  respected for all date formats, including fuzzy date formats.

- 📦 `extraDateTimeFormats` now includes additional formats to extract
  timestamps from filenames from LG, dashcam, and action cameras.

- 📦 Added operating system version health check (to make it clear we didn't
  support end-of-life OSes or Linux distributions that aren't Ubuntu, Debian,
  or Fedora), and removed the version check from `./start.sh`.

- 📦 Health checks now warn against ancient versions of `ffmpeg` and
  `heif-convert` (if version metadata is available).

- 📦 `backfillTimezones` and `inferTimezoneFromDatestamps` are now exposed by
  settings and enabled by default. [See the documentation for
  details](https://photostructure.github.io/exiftool-vendored.js/interfaces/ExifToolOptions.html#backfillTimezones).

- 📦 ExifTool `MWG` mode is now enabled by default. See the new `useMWG`
  setting to revert to prior behavior. See
  https://exiftool.org/TagNames/MWG.html for details.

- 📦 On Windows, `%SystemDrive%\cygwin64\bin` is now checked for external
  tooling even if it's not in the `%PATH%`

- 📦 Improved make/model handling for several new flagship mirrorless cameras

- 📦 `info` improvements:

  - Added PhotoStructure version metadata (including available updates for the current channel)
  - For given files, why (if at all) the file would be rejected from being imported
  - For given files, include all inferred metadata (like captured-at time, timezone, make, and model)

- 📦 File and directory exclusion globs can now conditionally applied,
  depending on if files are in your library or originals directories. If the
  new `excludeGlobsInLibrary` setting is `true`, prior exclusion glob
  application behavior will be in place, and if a library directory happens to
  match an exclusion glob, we won't import any files (!!). The default for
  this setting is `false`, which means we **won't** skip over files that match
  exclusion globs that are in the library or originals directory hierarchy.
  Note that files in NoMedia folders and hidden files (that start with `.`)
  are still be ignored.

- 📦 Pulled in latest third-party libraries, including SQLite and ExifTool

- 🛡️ Added a [regex
  linter](https://github.com/ota-meshi/eslint-plugin-regexp) to the build
  pipeline, and fixed several issues (including a couple that could result in
  super-linear backtracking)

## v2023.9.0-prealpha.17

**Released 2023 September 9**

- 🐛 Prior video transcoding timeouts were validated against .MOV and other older video formats. HEVC in 4K 60fps require 10x the CPU time, based on bytes to transcode--so prior builds would erroneously timeout video transcode operations _and then retry_, causing imports to crawl to a halt (and burn CPU time needlessly). The following fixes are in this build:

  - Video asset file imports now have _no timeouts_. I may reestablish this timeout in the future if we find people's sync getting "stuck" in `ffmpeg`, but I don't have a record of that.
  - The "is this previously transcoded file" test assumed a transcoded file would not be less than a quarter the size of the original file--but if we're downsampling videos, this limit isn't correct. The expected file size is now (duration \* bitrate), and a transcoded file can now be validly 10% of that size without requesting a new transcode.

- 🐛 CPU rendering code would return `undefined` for values higher than 100%--which would normally be a reasonable approach, but PhotoStructure uses an average of load and cpu usage statistics--if system load is higher than current CPU count, "busy percent" will exceed 100%.

- 🐛 Pulled in new exiftool-vendored build which avoids invalid datetime values from some cameras (like "00" and "01", which prior builds would _consider an obscure ISO reference to today's date_). Those invalid values are now properly ignored.

- 📦 A new "share" icon was added to the asset header, but most browsers do not support sharing embedded `blob`-based files, so most people won't see the icon :sob: (you can still long-press the asset image and share that, though)

## v2023.9.0-prealpha.16

**Released 2023 September 7**

- 🐛 Fixed `cpuUsage()` bug that could cause it to stay at `undefined`

- 🐛 Invalid values (like "00" and "01") associated to EXIF `SubSec` datetime fields could assume the current date (!!). This is now fixed.

- 🐛 The CPU busy code was incorrectly filtering all values (!!), which led to the `undefined` cpu percent in the health check

- 📦 Adjusted `maxCpus()` to account for `sync` load to more accurately schedule the correct number of import jobs

- 📦 `SystemLoadHealthCheck` now refreshes every minute

- 📦 Current system load was added to the `/about` page

- 📦 CPU count now uses [`node:os.availableParallelism()`](https://nodejs.org/dist/latest-v20.x/docs/api/os.html#osavailableparallelism) if available (Node.js v18+), and on Linux, `/sys/fs/cgroup/cpu/cpu.cfs_quota_us`, `/sys/fs/cgroup/cpu/cpu.cfs_period_us`, and `/sys/fs/cgroup/cpu/cpu.shares` are taken into account. The least value from all these methods is used for the "CPU count."

## v2023.9.0-prealpha.15

**Released 2023 September 6**

- 🐛 Fixed `ffmpeg` overscheduling by moving the `--threads` argument _after_ the input. The default value for `--threads` remains `clamp(1, 8, $PS_FFMPEG_THREADS ?? maxCpus() / 2)`, where `maxCpus()` is `$cpuCount * PS_CPU_LOAD_PERCENT`.

- 🐛 Fixed CPU utilization health check to refresh when a proper cpu load value was available.

- 🐛 `sync` will now run `Math.max(1, maxCpus() - 1)` workers. Previously it would schedule `maxCpus()` workers, which could result in overscheduling (especially on CPUs with only 1-4 threads)

## v2023.9.0-prealpha.13

**Released 2023 September 6**

- 🐛 Search `when:2023` didn't work (thanks for the [report](https://discord.com/channels/818905168107012097/1146105684648267886) and assistance, [@avdp](https://forum.photostructure.com/u/avdp/summary) and [@tkohhh](https://forum.photostructure.com/u/tkohhh/summary))

- 🐛 When rotating images with prior versions, `-Orientation` would always be delivered to sidecars (because the `PS_SIDECAR_TAG_BLOCKLIST` included `Orientation`, but we have to pass `-Orientation#` to ExifTool). Unfortunately, nothing respects sidecar `Orientation` values, so it resulted in images not being rotated properly. Thanks for example, @tkohhh!

- 🐛 Found and addressed several codepaths that could throw ["e.localBoundaries not a function"](https://discord.com/channels/818905168107012097/1138979196090200084)--JSON serialization for `Date` and `DateTime` were broken. Thanks for the reports, @slothstronaut, @ltlowe, and @HelloPanic!

- 🐛 Images with `stat`-only captured-at date variants should have more consistent aggregation. Thanks for the [report](https://discord.com/channels/818905168107012097/1139417790458114220), @nuk!

- 🐛 Search `Keywords:___` is now a valid alias for `kw:___`, which fixes the search result from clicking from keyword tags.

- 🐛 Improved dominant color extraction with arbitrary image rotations--images could be incorrectly dis-aggregated, especially for variants that were rotated by `Orientation` tag versus re-rastered with a different orientation.

- 🐛 PLUS licenses could fail to activate in some situations. This should be improved, but holler if you see an issue.

- 🐛 The settings page's library directory suggestions code could, in some situations, fail to suggest anything, resulting in an error. This was improved.

- 🐛 Health check validation on `web` now only waits for "critical" health checks (like library database validation) before moving from the splash screen onto the home page.

- 🐛 Volume metadata results could be postponed for a fraction of the short command timeout on some Linux boxes if `gio` wasn't installed. This was fixed.

- 🐛 `sync` is now properly restarted when settings are saved, which should fix ["initial scan not starting on it's own"](https://discord.com/channels/818905168107012097/1139175793222758441)--thanks for the report, @advp!

- 📦 Dropped `fsCache` for most codepaths--the mutex implementation proved to be problematic on some filesystems. Future versions may adopt a different caching strategy, but performance doesn't seem to be dramatically impacted (especially on systems with fast disks).

- 📦 Third party libraries were upgraded, including sharp, SQLite, and ExifTool.

- 📦 `Error` stacktraces are included in log metadata, which may help expedite issue reproduction.

## v2023.8.0-prealpha.12

**Released 2023 August 28**

- 📦 Skip `lsblk` on docker--the debian container doesn't see any host volume UUIDs.

## v2023.8.0-prealpha.11

**Released 2023 August 28**

- 🐛 PhotoStructure for Docker now ignores the root partition, `/`, for both volume metadata and as a scan path. This was accomplished by changing the default for the `PS_EXCLUDED_MOUNTPOINT_PATHS` setting to include `"/"` by default on docker. Thanks for the suggestion, [MK](https://www.mklibrary.com/)!

- 📦 Add wget to the docker image to satisfy the `HEALTHCHECK CMD` (thanks for the catch, [@avdp](https://forum.photostructure.com/u/avdp/summary)!)

## v2023.8.0-prealpha.10 ("Nighthawk TNG")

**Released 2023 August 28**

- 🐛 Fix docker error in `docker-entrypoint.sh` by directly `exec`ing `photostructure.js` rather than using `/usr/local/bin/node`

- 🐛 Fix spurious ["No eligible files found in scanned paths"](https://discord.com/channels/818905168107012097/1145860551956758660)

- 📦 Install `source-map-support` for better stacktraces

## v2023.8.0-prealpha.9 ("Nighthawk")

**Released 2023 August 28**

- 📦 v23.8.0-prealpha.9 fixes the base debian image, adds a missing dependency on `type-detect`, and updates several other third party libraries.

## v2023.8.0-prealpha.8

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
