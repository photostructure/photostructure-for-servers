# PhotoStructure tools

PhotoStructure requires several external tools to get work done:

- [ExifTool](https://exiftool.org/), provided by [exiftool-vendored](https://github.com/photostructure/exiftool-vendored.js), for file metadata reading and writing for Desktops

- [SQLite](https://sqlite.org/) to store the PhotoStructure library database and persistant work queues

- [jpegtran](https://libjpeg-turbo.org/) for lossless JPEG rotations

- [LibRaw](https://www.libraw.org/) for RAW image conversions

[PhotoStructure for Desktops](https://photostructure.com/install/) includes the relevant subdirectory to ensure these tools are available for those users.

For [PhotoStructure for Docker](https://photostructure.com/server/photostructure-for-docker/), [Alpine Linux](https://www.alpinelinux.org/), the OS that PhotoStructure uses for the Docker image, has up-to-date binaries of all necessary tools, so the `Dockerfile` installs those Alpine packages, and the Docker image can exclude this entire tools directory.

For [PhotoStructure for Node](https://photostructure.com/server/photostructure-for-node/), we have a bit less control about what tools are available. Linux distributions, like Ubuntu, typically include stable versions from a year or more ago, which may not be recent enough for PhotoStructure.

## Building tools

See `./build.sh` which handles building linux-x64 and linux-arm64 binaries.

Windows binaries are from the official SQLite distribution, and macOS binaries are built from source.
