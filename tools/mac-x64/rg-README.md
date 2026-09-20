# `rg`

Downloaded from the official
[ripgrep 15.2.0](https://github.com/BurntSushi/ripgrep/releases/tag/15.2.0)
release.

Downloaded archive:

- URL: <https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/ripgrep-15.2.0-x86_64-apple-darwin.tar.gz>
- SHA-256: `af7825fcc69a2afc7a7aea55fc9af90e26421d8f20fe59df32e233c0b8a231c1`

Bundled executable:

- SHA-256: `0c9a0066db0d26b640777db88045b0ccdd58509a746700e43e1c4ff8707a5ed0`
- [VirusTotal report: 0/62 security vendors flagged it](https://www.virustotal.com/gui/file/0c9a0066db0d26b640777db88045b0ccdd58509a746700e43e1c4ff8707a5ed0/detection)
  (verified 2026-08-24).

## Reproduce

```sh
SCRATCH="$(mktemp -d /tmp/phstr-rg-x64-XXXXXX)"
ARCHIVE="ripgrep-15.2.0-x86_64-apple-darwin.tar.gz"
curl -fsSL -o "$SCRATCH/$ARCHIVE" \
  "https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/$ARCHIVE"
tar -xzf "$SCRATCH/$ARCHIVE" -C "$SCRATCH"
```

## Verification

- `rg --version` reports `ripgrep 15.2.0 (rev e89fff89ac)`.
- x86_64 Mach-O executable with only system `libiconv` and `libSystem` dynamic
  dependencies.
- Under Rosetta, a fixed-string count against `tools/README.md` returned the
  expected match.
