
<div class="release-notes">

This is a detailed list of changes in each version.

- Major releases have posts summarizing bigger changes. See [the posts tagged with "release notes"](/tags/release-notes/).

- New releases, starting in 2023, use "calendar versioning," or [CalVer](https://calver.org/), using scheme `YYYY.MM.BUILD`. `BUILD` starts at zero at the beginning of the month, and gets incremented for every prealpha, alpha, beta, or stable release. For non-stable releases, `-$channel` is appended to the version format.

- "Pre-release" builds (marked with `-alpha` or `-beta`) have not been thoroughly tested, and may not even launch.

- Only run `alpha` or `beta` builds if you have [recent backups](/faq/how-do-i-safely-store-files/).

- Upgrades to new versions are automatic, but older versions of PhotoStructure may not be able to open libraries created by newer versions of PhotoStructure.

<!-- TODO: -->
<!-- - 🐛 Sync doesn't seem to no-op properly for a completed directory -->
<!-- - 🐛 Tag gallery is not sorted and has too many rows -->

<!-- - ✨ Logs are now viewable in the UI -->
<!-- - 🐛 [Tag reparenting doesn't seem to work properly on rebuilds](https://forum.photostructure.com/t/who-tags-are-incorrectly-excluded-from-keywords/676/6?u=mrm). -->
<!-- - 🐛 Sync resume (after pause) on mac via the menubar (not the main window nav button) doesn't seem to support "resume" properly -->

<!-- fix "tag context" for "next previous" context. I'd always done a search, clicked a thumb, and then clicked esc to go back to the search results. But...  if you click a thumb from a search,  and then click "next" or "previous", it ignores that you can from a search, and does the chronological next asset, which is very confusing/irritating. -->

<a id="v2024.3.1-prealpha"></a>
## v2024.3.1-prealpha ["Zep"](https://discord.com/channels/818905168107012097/818905168690413611/1215774241979502612)

**Released 2023-03-08**

- 🐛 Extended database migration timeouts to 2 minutes by default. See `dbMaintenanceTimeoutMs` setting for details. Should resolve [this issue](https://discord.com/channels/818905168107012097/818907922767544340/1215748274401710191).

- 🐛 Added new migration to re-assert the `Progress` table schema. Should resolve [this issue](https://discord.com/channels/818905168107012097/1215730724020293752).

- 🐛 The webservice now re-writes `settings.toml` files from prior versions, to ensure the latest settings are visible. Thanks for reporting, [@tkohhh](https://discord.com/channels/818905168107012097/1215760858664140841)! Older versions of `settings.toml` are now moved to `./archive` (it had been `./old`).

- 🐛 `sync` won't be started if any health checks post fatal errors.

- 🐛 `main` renders service startup errors to `stderr` now _and still tries to spin up the web service_ (in an effort to try to get the health check page to the user)

<a id="v2024.1.0-alpha"></a>
<a id="v2024.2.0-alpha"></a>
<a id="v2024.3.0-alpha"></a>

## v2024.3.0-prealpha

**Released 2023-03-08**

### ✒️ Version format change

I'm adopting a simpler version format: `$year.$month.$build`, where `$build` starts at zero at the beginning of the month, and gets incremented for every prealpha, alpha, beta, or stable release. For non-stable releases, `-$channel` is appended to the version format.

As an example, a build might be `v2024.1.7-beta`. If it proves sufficiently stable, the same code may be re-released as `v2024.1.7`.

### 🗺️ New geo location tagger

PhotoStructure now adds `Where/Country/Region/City` tags for those photos and videos with Latitude and Longitude metadata.

Note that this feature is uses an embedded geo database, so no network access is required. This initial implementation only inclues cities with a population of 1000 or greater. See the new `tagGeo` and `tagGeoTemplate` [settings](/go/settings) for more details.

### 🔃 Sync improvements

Previous builds of PhotoStructure had two work queues: one single-threaded work queue for videos, and one multithreaded work queue for images. This was a ~~hack~~ workaround to prevent concurrent `ffmpeg` invocations as `ffmpeg` attempts to use all cores by default, resulting in CPU overscheduling.

We've since found a fairly reliable way to single-thread ffmpeg, so `sync` now schedules both video and image work in a single queue, which greatly simplifies the code, and results in higher parallelism (!!). Anecdotally, prior builds would sync several hundred exemplar videos and photos in roughly 3 minutes. This build now completes that same task in under 90 seconds on the same hardware.

PhotoStructure's task queuing system was also rewritten. Previous builds used a completely separate SQLite schema and database for work scheduling, in an attempt to keep that workload partitioned from the `web` service. With the new `taskListCap` setting, task schedulers receive backpressure if the `Task` table is "full." This backpressure ensures the table doesn't grow unbounded, so it felt safe to migrate it into the `models` database and delete the work queue database. This also allows `web` to schedule work for `sync` reliably without socket RPC or JSON watchfile overhead (again, allowing another good chunk of code to be deleted).

### 🐕 New stuck-task watchdog

For larger libraries with tens of thousands of `ffmpeg` transcodes, a `sync` could get "stuck" waiting for an ffmpeg transcode completion that exited abnormally. v2 builds had a hard timeout value based on video duration, but that proved problematic for slower computers and for more advanced codecs that require more computation to decode, so video transcode timeouts were dropped in v2023. More advanced video transcode timeouts were built that adjusted dynamically based on current system performance and processed pixel count, but this implementation was difficult to test rigorously, and the least-squares interpolation implementation was replaced with a new stuck-task watchdog.

When users reported their sync process was "stuck," they'd always report that their system's CPU was idle but that things weren't done.

So, instead of fancy-pants pixels-processed-per-mimetype least-squares timeout interpolation complexity, _why can't PhotoStructure just do what the users are doing in these situations?_

So now it does!

While `sync` is currently processing, every five minutes it will check if the system load is "idle" (by default, less than 50% of one busy core, but this is adjustable). If it is, any task that has run longer than the last check will be assumed to be stuck, and will be marked as failed. See the new `stuckCheckIntervalMs` and `minBusyPct` settings for more details.

To make this work, Tasks are now be abortable externally, and know how to clean up gracefully, including killing child processes and notifying sync-report.

### Improvements and bug fixes

- ✨ Sync is now scheduled by a crontab entry. Prior builds waited a static amount of time between completion of last sync and start of next sync, which resulted in unpredictable sync run times. By default PhotoStructure will now kick off `sync` every night at 2AM local time, but this is configurable now--and don't worry, any scheduling overruns are automatically skipped. See `syncCron` and `syncCronTZ` settings for details -- **be sure to set `syncCronTZ` to ensure "2AM" really is in local time**.

- 🐛 Fixed `Error: cannot store REAL value in INTEGER column Progress.completePct`. This could cause library upgrades from v1.1.0 to fail as well. [Thanks for reporting, Alan!](https://discord.com/channels/818905168107012097/818907922767544340/1193326788466724912)

- 🐛 Using force-sync via the nav menu in some situations would _only work once_, as the persistent operation wasn't resolved after sync completed if there were any rejected tasks. This should be resolved.

- 🐛 `.NoMedia` could be ignored in some situations after initial directory scans. This should be resolved.

- 🐛 There were several edge cases that could prevent `sync` from properly no-op'ing unchanged files, which could result in `sync` taking a long time to process previously-scanned directories. This should be resolved.

- 🐛 PhotoStructure for Docker's About > Sync Information table could show the library path twice. This should be resolved. [Thanks for the report, Gijsh!](https://forum.photostructure.com/t/two-libraries/2113)

- 🐛/📦 Overlapping "Empty trash" and "Remove assets" actions could result in only a subset of assets actually being removed or excluded. These operations have been converted to the new task infrastructure with serial mutexes to avoid issues around concurrency.

- 🐛/📦 `LibRAW`'s support for a number of current flagship mirrorless camera RAW file formats is... _not great_. PhotoStructure can still show a preview for those RAW images, most of which embed a full-resolution JPEG, so we're changing the default setting for `validateRawImages` to be `false` in this build. Future builds will probably switch to using rawtherapee for RAW rasterization.

- 📦 `Empty trash` and `Remove assets` now write sync report records.

- 📦 `SyncDirectory` writes both scan-complete and sync-complete sync report records with elapsed time.

- 📦 Added `excludeHidden` setting:

  > PhotoStructure may check for filesystem "hidden" metadata flags on macOS and Windows filesystems, and automatically skip importing those files.
  >
  > As of v2023, this defaults to "false", as most people don't use this filesystem feature, and it's expensive for PhotoStructure to check for this flag on every file it imports.
  >
  > This setting is ignored on Linux systems.

- 📦 Added `skipWriteVolumeUuidFilesWithNoMedia` setting:

  > When true, PhotoStructure will NOT write files with universally unique identifiers into the root directory of volumes that have been marked with a [NoMedia file or folder](https://phstr.com/nomedia). If writeVolumeUuidFiles is false this setting is ignored.

- 📦 Added `workQueueHighWater`/`taskListCap` setting:

  > When PhotoStructure scans a directory, the first step is to walk the directory and search for files to import. When the work queue is larger than this value, sync will pause looking for additional files to process. This limits the size of the work queue to not fall over when there are hundreds of thousands or millions of files to import due to IOWAIT or memory oversubscription. Note that until the last batch of work is scheduled, ETAs will be inaccurate.
  >
  > Set this to 0 to disable.

- 📦 Added `maxValidFutureMs` setting:

  > If PhotoStructure encounters a year that is more than this value in the future, it will consider that source to be invalid and look elsewhere for the captured-at date for that given file.
  >
  > Set to 0 to disable future date filtering.

- 📦 Added `forceFilters` setting:

  > When set, all files filters will be applied to visited files. If this is false, files already in the library database will be assumed to be validly passing all import filters. This is set to true by default when rebuilding libraries.
  >
  > This setting is transient and only set via environment variables.

- 📦 Setting `cpuBusyPercent=0` now supports "single threaded" mode, which tells sync to:

  - **ignore system load**, and
  - **consume one CPU core (roughly)**

  Note that we don't do CPU pinning, so load from the single-threaded process will probably bounce across portions of different cores, depending on your OS. Expect system load to be about 0.75-1.5 (or about ~75-150% of a core) due to graphics, SQLite, ExifTool overhead.

- 📦 Database maintenance tasks and relevant health check timeouts have been extended to 1 minute and can be configured with `dbMaintenanceTimeoutMs` setting, which default to 1 minute _per database operation_

- 📦 `start.sh`, used by the [PhotoStructure for Node](https://photostructure.com/server/photostructure-for-node/) edition, will now `source` your `~/.psenv` (if it's a readable file), and will start up if there is no external network available and all current dependencies are already installed. [Read more about psenv here.](https://photostructure.com/server/photostructure-for-node/#psenv)

- 📦 Maintenance tasks check periodically if the service is ending, rather than running to completion (which could take several minutes, causing the library database to be left in a corrupt state).

- 📦 `taskTimeoutMs` and `commandTimeoutMs` can now be validly `0`: previous builds would pass this value directly on to [batch-cluster](https://photostructure.github.io/batch-cluster.js/classes/BatchClusterOptions.html#taskTimeoutMillis), which does not accept values of less than 10.

- 📦 `AbortError`s are no longer considered "retriable" (which could cause issues under high concurrency).

- 📦 Tag asset count rebuilds now run non-recursive updates for leaf tags, which are dramatically faster than CTE queries. This can speed up tag asset count rebuilds for larger libraries by more than 5-10x. You can force a `Tag.assetCount` rebuild with `./photostructure info --reindex`.

- 📦 Replace `axios` with direct `node:http` (less dependencies are always better)

- 📦 Volume and mountpoint watches are now only enabled if `scanAllDrives` is enabled. This may reduce idle CPU and disk activity.

- 📦 When available, volume and mountpoint metadata reads directly from `/proc/` instead of forking `df` and `mount` to gather the same information.

- 📦 Library rebuilds now serialize only asset re-aggregation tasks. All other steps are parallelized.

- 📦 `UV_THREADPOOL_SIZE` can be overridden via the new `webUvThreads` and `syncUvThreads` settings:

  > Higher values may allow for more concurrent requests, but may also consume more memory and CPU and overwhelm non-SSD storage. The default is 4, which should be fine for most installations. Read more about `UV_THREADPOOL_SIZE`: https://nodejs.org/api/cli.html#cli_uv_threadpool_size_size

- 🐛 Several tools didn't respond correctly to the `--no-color` option.

- 📦 Non-retriable library database errors now force-close and reopen the database handle, which should make error recovery more robust.

- 📦 Most file operations now use "work-in-progress" files. These files are now unique _per-call_ (using `.WIP-${RANDOM_SHORT_UID}-${destination_basename}`), which helps avoid issues from inadvertent concurrent file operations.

- 📦 Database models are now batch-reloaded on upsert, which can dramatically reduce db query load during `sync`.

- 📦 When `sync` is killed or shut down while actively importing files, those files are now marked as a new `canceled` state in the sync report. The next time `sync` is restarted, those tasks should be retried automatically. Prior builds would mark those files as failed and require another full `sync` run to recover gracefully.

### 🔦 `list` improvements:

- 📦 The `list` tool has a bunch of new options:

  ```
  --primary        Only include the primary, or "best" asset file variation
                   found for every asset. See https://phstr.com/dedupe for
                   details.

  --no-primary     Exclude primary asset file variation for every asset.
                   This is mutually exclusive with the --primary option,
                   and returns all rows that option omits.

  -0, --print0     Print each full native path name to standard output,
                   followed by a null character (instead of the newline
                   character).
                   This is suitable for properly handling filenames that
                   include whitespace characters in shell pipelines using
                   commands like xargs, which has a "--null" mode which
                   expects filenames to be separated by the null character.
                   This cannot be used with --json or --dump.

  --todo           List the currently enqueued files that sync is going to
                   process next. Implies --json. Does not support --print0.

  --tags           List all tag paths along with their counts. Implies
                   --json. Does not support --print0.
  ```

- 🐛 `list --limit` works now. Prior builds could miss adding the sql `LIMIT` clause to the query.

- 🐛 `list --json` now emits a valid JSON array of objects, so you can pipe the output to, say, `jq .` Prior builds would emit individual JSON objects separated by newlines, which most JSON-consuming tools don't know how to deal with.

## Prior release notes

- [**Release notes from 2023**](/about/2023-release-notes)

- [**Release notes from 2022**](/about/2022-release-notes)

- [**Release notes from 2021**](/about/2021-release-notes)

- [**Release notes from 2020**](/about/2020-release-notes)

- [**Release notes from 2019**](/about/2019-release-notes)

</div>
