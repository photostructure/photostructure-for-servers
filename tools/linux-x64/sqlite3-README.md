# Linux x64 SQLite CLI

- SQLite 3.53.4 source: https://sqlite.org/2026/sqlite-autoconf-3530400.tar.gz
- Source SHA-256: `0e9483900e92cd5de8fd48d16bf9200145a61f7fd5be542a5ac81d8a9516eb9c`
- Build: `base-tools-debian` commit `27a782e` in Alpine 3.23 with GCC 15.2.0, musl, static readline and zlib. Extract from the pinned image with `bash tools/build.sh`.
- Binary SHA-256: `4aaf1a0930878f65ffd06643468a629c4eb3fedbb92b70925120061524bfc334`
- Verified with `bash tools/test-sqlite-nss.sh` (version and SQL query on Ubuntu 24.04 with `passwd: compat`).
