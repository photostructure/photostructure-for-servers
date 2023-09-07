Applied on Debian 11 x64:

```sh
sudo apt install -y build-essential curl

source <(egrep "^(YEAR|VERSION)=" $HOME/src/photostructure/src/library/node_modules/better-sqlite3/deps/download.sh)

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

To validate the binary is static:

