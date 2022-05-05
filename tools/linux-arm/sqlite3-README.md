To reproduce on a Raspberry Pi 4 running Debian Bullseye:

```
export VER=3380200
cd ~/src
curl -o - https://sqlite.org/2022/sqlite-autoconf-$VER.tar.gz | tar xz
cd sqlite-autoconf-$VER
./configure --enable-static --enable-readline
make -j4
strip sqlite3
cp sqlite3 ~/src/photostructure/tools/linux-arm/sqlite3
```
