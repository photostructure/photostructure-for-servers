To reproduce on a Raspberry Pi 4 running Debian Bullseye:

```sh
source <(egrep "^(YEAR|VERSION)=" /home/mrm/src/photostructure/src/library/node_modules/better-sqlite3/deps/download.sh)

export DEST=/tmp/sqlite-$VERSION

mkdir -p $DEST \
 && cd $DEST \
 && curl https://sqlite.org/$YEAR/sqlite-autoconf-$VERSION.tar.gz | tar -xz --strip 1 \
 && ./configure --enable-static --disable-readline --disable-shared LDFLAGS="-static -pthread" \
 && make clean \
 && make -j `nproc` \
 && strip sqlite3 \
 && cp sqlite3 ~/src/photostructure/tools/linux-arm \
 && scp sqlite3 speedy:src/photostructure/tools/linux-arm

```

ldd should report "not a dynamic executable:" (thanks to "-static"):
`ldd sqlite3`