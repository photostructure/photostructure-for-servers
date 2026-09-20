# `sqlite3`

Downloaded from SQLite.org's official
[SQLite 3.53.4](https://sqlite.org/releaselog/3_53_4.html) macOS tools archive.

Downloaded archive:

- URL: <https://sqlite.org/2026/sqlite-tools-osx-x64-3530400.zip>
- SHA-256: `76c187f19990c4a6fe9a4f8d01de038a63fc339aaf9d491202c9c56d058cb110`
- Official SHA3-256: `3353bb4e5ac54f85c5b82012d30476d20539a9495abdd11a1707df578cff2d7e`

Bundled executable:

- SHA-256: `212d96d4b5eb33f2490e5f2ce5a11d89a0f85132b97f93bb1cfc7e07154c2f14`
- [VirusTotal report: 0/62 security vendors flagged it](https://www.virustotal.com/gui/file/212d96d4b5eb33f2490e5f2ce5a11d89a0f85132b97f93bb1cfc7e07154c2f14/detection)
  (verified 2026-08-24).

## Reproduce

```sh
SCRATCH="$(mktemp -d /tmp/phstr-sqlite-x64-XXXXXX)"
curl -fsSL -o "$SCRATCH/sqlite-tools.zip" \
  "https://sqlite.org/2026/sqlite-tools-osx-x64-3530400.zip"
unzip "$SCRATCH/sqlite-tools.zip" -d "$SCRATCH"
```

## Verification

- `sqlite3 --version` reports `3.53.4`.
- x86_64 Mach-O executable whose dynamic dependencies are only
  `/usr/lib/libz.1.dylib` and `/usr/lib/libSystem.B.dylib`.
- Under Rosetta, an in-memory create/insert/select transaction returned
  `mac-tools-ok`.
