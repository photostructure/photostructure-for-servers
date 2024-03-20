# sqlite3

This SQLite binary was created from
<https://sqlite.org/> and compiled on macOS
10.15 (Catalina)

Unfortunately, the binaries published on sqlite.org are 32-bit, and macOS 10.13
and later complain about 32-bit binaries, so we can't use the precompiled
binaries from SQLite. See <https://support.apple.com/en-us/HT208436>.

Compiled using all defaults:

(if curl fails due to curl: (60) SSL certificate problem: certificate has expired, `brew install curl`.)

```sh
bash # to avoid zsh

brew install curl

YEAR=2022
VERSION=3400000

mkdir -p /tmp/sqlite \
  && cd /tmp/sqlite \
  && curl https://sqlite.org/$YEAR/sqlite-autoconf-$VERSION.tar.gz | tar -xz --strip 1 \
  && ./configure --enable-static-shell --enable-static --disable-readline --disable-shared \
	&& make clean \
  && make -j `sysctl -n hw.physicalcpu` \
  && strip sqlite3 \
  && cp sqlite3 ~/src/photostructure/tools/mac-arm64/sqlite3
  && make clean \
  && arch -x86_64 make -j `sysctl -n hw.physicalcpu` \
  && strip sqlite3 \
  && cp sqlite3 ~/src/photostructure/tools/mac-x64/sqlite3
```

Validated that required dynamic libraries seem reasonable:

```sh
$ otool -L sqlite3

sqlite3:
	/usr/lib/libedit.3.dylib (compatibility version 2.0.0, current version 3.0.0)
	/usr/lib/libncurses.5.4.dylib (compatibility version 5.4.0, current version 5.4.0)
	/usr/lib/libz.1.dylib (compatibility version 1.0.0, current version 1.2.5)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1226.10.1)
```

And that it compiled a 64-bit binary:

```sh
$ file sqlite3
sqlite3: Mach-O 64-bit executable x86_64
```
