# `sqlite3`

SQLite.org publishes only an x86_64 macOS binary, so this arm64 executable was
built locally from the [SQLite 3.53.4](https://sqlite.org/releaselog/3_53_4.html)
autoconf source archive.

Source archive:

- URL: <https://sqlite.org/2026/sqlite-autoconf-3530400.tar.gz>
- SHA-256: `0e9483900e92cd5de8fd48d16bf9200145a61f7fd5be542a5ac81d8a9516eb9c`
- Official SHA3-256: `454e45f61c6bd75b7420e7190732dea03ce6639c63ada47bbc592f67fc340338`

This executable was compiled locally, not downloaded as a binary.

## Reproduce

```sh
SCRATCH="$(mktemp -d /tmp/phstr-sqlite-arm64-XXXXXX)"
VERSION="3530400"
curl -fsSL -o "$SCRATCH/sqlite.tar.gz" \
  "https://sqlite.org/2026/sqlite-autoconf-$VERSION.tar.gz"
mkdir -p "$SCRATCH/source"
tar -xzf "$SCRATCH/sqlite.tar.gz" -C "$SCRATCH/source" --strip-components=1
cd "$SCRATCH/source"
./configure --enable-static --disable-shared --disable-readline
make -j8
strip sqlite3
```

## Verification

- SHA-256: `0a9e943cf63b480cf42309b6c34c3e3617786a80725fab9a85e837e1826db6db`
- `sqlite3 --version` reports `3.53.4`.
- arm64 Mach-O executable whose dynamic dependencies are only
  `/usr/lib/libz.1.dylib` and `/usr/lib/libSystem.B.dylib`.
- An in-memory create/insert/select transaction returned `mac-tools-ok`.
