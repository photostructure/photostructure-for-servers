Applied on Ubuntu 22.04 x64:

To make a static binary, we have to disable readline, and as of 3.42.0, we
have to yank the `./libtool` line from `make` and add `-all-static` right after
`gcc`.

```sh
source <(egrep "^(YEAR|VERSION)=" /home/mrm/src/photostructure/src/library/node_modules/better-sqlite3/deps/download.sh)

export DEST=/tmp/sqlite-$VERSION

mkdir -p $DEST \
  && cd $DEST \
  && curl https://sqlite.org/$YEAR/sqlite-autoconf-$VERSION.tar.gz | tar -xz --strip 1 \
  && ./configure --enable-static --disable-readline LDFLAGS="-static -pthread" \
  && make clean \
  && make -j `nproc` \
  && strip sqlite3 \
  && cp sqlite3 ~/src/photostructure/tools/linux-x64

```
