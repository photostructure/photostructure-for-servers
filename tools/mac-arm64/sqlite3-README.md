# sqlite3

Compiled from <https://sqlite.org/> source on an Apple Silicon Mac.

sqlite.org only publishes x64 macOS prebuilts, so the arm64 binary must be
compiled from source.

```sh
export YEAR="2026"
export VERSION="3510200"
export DEST=/tmp/sqlite-$VERSION

mkdir -p $DEST \
  && cd $DEST \
  && curl https://sqlite.org/$YEAR/sqlite-autoconf-$VERSION.tar.gz | tar -xz --strip 1 \
  && ./configure --enable-static-shell --enable-static --disable-readline --disable-shared \
  && make clean \
  && make -j $(sysctl -n hw.physicalcpu) \
  && strip sqlite3 \
  && cp sqlite3 ~/src/photostructure/tools/mac-arm64/sqlite3
```

Validated dynamic library dependencies (only system libs):

```sh
$ otool -L sqlite3
sqlite3:
	/usr/lib/libz.1.dylib (compatibility version 1.0.0, current version 1.2.12)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1351.0.0)
```

```sh
$ file sqlite3
sqlite3: Mach-O 64-bit executable arm64
```
