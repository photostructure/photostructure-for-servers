# Linux arm64 SQLite CLI

- SQLite 3.53.4 source: https://sqlite.org/2026/sqlite-autoconf-3530400.tar.gz
- Source SHA-256: `0e9483900e92cd5de8fd48d16bf9200145a61f7fd5be542a5ac81d8a9516eb9c`
- Build: `base-tools-debian` commit `27a782e` in Alpine 3.23 with GCC 15.2.0, musl, static readline and zlib. Extract from the pinned image with `bash tools/build.sh`.
- Binary SHA-256: `ddcadd648d9a6c4c9fa090718e7e67e12540964e02b04e89f69a82ae58839ce2`
- Verified with `bash tools/test-sqlite-nss.sh tools/linux-arm64/sqlite3 linux/arm64` (version and SQL query on Ubuntu 24.04 with `passwd: compat`).
