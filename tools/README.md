# PhotoStructure tools

PhotoStructure requires several external tools to get work done:

- [ExifTool](https://exiftool.org/), provided by [exiftool-vendored](https://github.com/photostructure/exiftool-vendored.js), for file metadata reading and writing for Desktops

- [SQLite](https://sqlite.org/) to store the PhotoStructure library database and persistent work queues

- [jpegtran](https://libjpeg-turbo.org/) for lossless JPEG rotations

- [LibRaw](https://www.libraw.org/) for RAW image conversions

- [ripgrep](https://github.com/BurntSushi/ripgrep) for fast structured log querying with context

[PhotoStructure for Desktops](https://photostructure.com/install/) includes the relevant subdirectory to ensure these tools are available for those users.

For [PhotoStructure for Node](https://photostructure.com/server/photostructure-for-node/), we have a bit less control about what tools are available. Linux distributions, like Ubuntu, typically include stable versions from a year or more ago, which may not be recent enough for PhotoStructure.

## Upgrade provenance and malware scans

These requirements apply to every platform directory under `tools/`, including
Linux, macOS, and Windows:

- Check every downloaded executable and shared library individually on
  [VirusTotal](https://www.virustotal.com/). Require zero detections, then record
  the direct file-report URL, binary SHA-256, exact source version, and download
  URL in an adjacent `*-README.md`. An archive scan does not replace scans of
  the binaries extracted from it.
- For locally compiled binaries, record the exact source commit, compiler, and
  reproducible build command instead of a VirusTotal URL.
- Verify the architecture and dynamic-library dependencies, run the version
  command (or equivalent), exercise one real operation, and review
  `tools/licenses/` before committing an upgrade.

## Building Linux tools

All Linux static binaries (LibRaw, SQLite, jpegtran) are built by [base-tools-debian](https://github.com/photostructure/base-tools-debian). The `Dockerfile` here simply extracts them from that image. Run `./build.sh` to produce linux-x64 and linux-arm64 binaries.

Windows and macOS x64 binaries are from the official SQLite distribution. The macOS arm64 binary is built from source (see `mac-arm64/sqlite3-README.md`).
