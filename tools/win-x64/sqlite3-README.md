# SQLite

Version 3.53.4, extracted from the official
[`sqlite-tools-win-x64-3530400.zip`](https://sqlite.org/2026/sqlite-tools-win-x64-3530400.zip).

- Archive SHA-256: `f46ee2475de4cbe287e6e5f7d43c838796b14e7379cd216bdbb28d391429f9fc`
- Archive SHA3-256: `88b4659fe747896b853af10157316b4ade143553efb89c1c8ca7423a278dcc8b`
  (matches sqlite.org)
- `sqlite3.exe` SHA-256: `5da2398d4913b893bd1ea578d85403b3a83a06fabf9d2303ca9f63ef0849fc6f`
- [VirusTotal: 0/61 detections](https://www.virustotal.com/gui/file/5da2398d4913b893bd1ea578d85403b3a83a06fabf9d2303ca9f63ef0849fc6f)

`dumpbin` reports an x64 PE executable whose only dynamic dependency is
`KERNEL32.dll`. A scratch database passed create, insert, select, and
`PRAGMA integrity_check` (`ok`).
