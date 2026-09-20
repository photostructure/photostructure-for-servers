# ripgrep

Version 15.2.0, extracted from the official
[`ripgrep-15.2.0-aarch64-unknown-linux-gnu.tar.gz`](https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/ripgrep-15.2.0-aarch64-unknown-linux-gnu.tar.gz).

- Archive SHA-256: `a740b91c82eaf9914cfedd353572f2791cbe0162c84101ee0951058f4dcbc90d`
- `rg` SHA-256: `e36d0eb52e70696bdf1781392722e05a21bb91d3b7b762ef5ec20e5df2ec687b`

Upstream ships no musl build for aarch64, so unlike `linux-x64` this one is a
glibc binary and links dynamically. That is fine for the Debian-based Docker
image and for PhotoStructure for Node on any glibc arm64 distribution.

## Reproduce

```sh
PROJECT_ROOT=$(git rev-parse --show-toplevel)
"$PROJECT_ROOT/tools/download-rg.sh" 15.2.0
```

`download-rg.sh` refreshes every platform at once. Pass no version to take
whatever upstream currently marks latest.

## Verification

- `file` reports an aarch64 ELF `dynamically linked`, interpreter
  `/lib/ld-linux-aarch64.so.1`, for GNU/Linux 3.7.0, stripped.
- Checked out and hashed on an x86-64 host, so `rg --version` and a functional
  search were **not** run against this binary. Confirm both on arm64 hardware or
  under emulation before trusting a release that depends on it.
