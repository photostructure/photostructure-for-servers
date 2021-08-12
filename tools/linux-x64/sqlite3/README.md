Applied on Ubuntu 20.04:

```
VER=3360000
cd ~/src
curl -o - https://sqlite.org/2021/sqlite-autoconf-$VER.tar.gz | tar xz
cd sqlite-autoconf-$VER
./configure --enable-static --enable-readline
make -j24
strip sqlite3
cp sqlite3 ~/src/photostructure/tools/linux-x64/sqlite3
```
