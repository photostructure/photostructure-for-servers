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

mkdir -p ~/src
cd ~/src

source <(egrep "^(YEAR|VERSION)=" /home/mrm/src/photostructure/src/library/node_modules/better-sqlite3/deps/download.sh)

curl -o - https://sqlite.org/$YEAR/sqlite-autoconf-$VERSION.tar.gz | tar xz
cd sqlite-autoconf-$VERSION
./configure --enable-static-shell --enable-static --disable-readline --disable-shared
make -j6
strip sqlite3
arch=$(node -e "console.log(require('os').arch())")
cp sqlite3 ~/src/photostructure/tools/mac-$arch/sqlite3
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

```sh
mrm@mini sqlite-autoconf-3390100 % ./sqlite3
SQLite version 3.39.1 2022-07-13 19:41:41
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .version
SQLite 3.39.1 2022-07-13 19:41:41 7c16541a0efb3985578181171c9f2bb3fdc4bad6a2ec85c6e31ab96f3eff201f
zlib version 1.2.11
clang-13.1.6
sqlite> ^D
```