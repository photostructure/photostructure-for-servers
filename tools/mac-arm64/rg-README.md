# `rg`

Downloaded from the official
[ripgrep 15.2.0](https://github.com/BurntSushi/ripgrep/releases/tag/15.2.0)
release.

Downloaded archive:

- URL: <https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/ripgrep-15.2.0-aarch64-apple-darwin.tar.gz>
- SHA-256: `3750b2e93f37e0c692657da574d7019a101c0084da05a790c83fd335bad973e4`

Bundled executable:

- SHA-256: `a326a1fb48074202e9ad41e4cd1e389eeea372c8c6f7d7e80da81176d5d9430e`
- [VirusTotal report: 0/62 security vendors flagged it](https://www.virustotal.com/gui/file/a326a1fb48074202e9ad41e4cd1e389eeea372c8c6f7d7e80da81176d5d9430e/detection)
  (verified 2026-08-24).

## Reproduce

```sh
SCRATCH="$(mktemp -d /tmp/phstr-rg-arm64-XXXXXX)"
ARCHIVE="ripgrep-15.2.0-aarch64-apple-darwin.tar.gz"
curl -fsSL -o "$SCRATCH/$ARCHIVE" \
  "https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/$ARCHIVE"
tar -xzf "$SCRATCH/$ARCHIVE" -C "$SCRATCH"
```

## Verification

- `rg --version` reports `ripgrep 15.2.0 (rev e89fff89ac)`.
- arm64 Mach-O executable with only system `libiconv` and `libSystem` dynamic
  dependencies.
- A fixed-string count against `tools/README.md` returned the expected match.
