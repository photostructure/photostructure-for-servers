Applied on Ubuntu 20.04:

```
$ cd ~/src
$ curl -o - https://sqlite.org/2021/sqlite-autoconf-3350200.tar.gz | tar xz
$ cd sqlite-autoconf-3350200
$ ./configure --enable-static --enable-readline
$ make -j 24
$ strip sqlite3
$ cp sqlite3 ~/src/photostructure/tools/linux-x64/sqlite3
```
