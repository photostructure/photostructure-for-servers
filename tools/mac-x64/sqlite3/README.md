# sqlite3

This sqlite binary was created from the `sqlite-autoconf-NNN.tar.gz` source
fetched from <https://sqlite.org/download.html> and compiled on macOS 10.11.6.

Unfortunately, the binaries published on sqlite.org are 32-bit, and macOS 10.13
and later complain about 32-bit binaries. See
<https://support.apple.com/en-us/HT208436>.

Compiled using all defaults:

```sh
./configure
make
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

And that it actually compiled a 64-bit binary:

```sh
$ file sqlite3
sqlite3: Mach-O 64-bit executable x86_64
```
