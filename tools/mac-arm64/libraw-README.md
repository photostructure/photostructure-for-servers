# Static build of `dcraw_emu` and `raw-identify`

To reproduce on macOS:

```sh
brew install autogen autoconf automake libtool pkg-config libjpeg zlib

mkdir -p ~/src
cd ~/src
git clone https://github.com/LibRaw/LibRaw.git --depth 3
cd LibRaw
git clean -dfx
git checkout --force 6fffd414bfda63dfef2276ae07f7ca36660b8888

export LDFLAGS="-L/opt/homebrew/lib"
autoreconf -fiv
./configure --enable-static --disable-lcms --disable-openmp

make -j8

# With lcms? Nope: fails with /usr/bin/ld: cannot find -llcms2

# With omp? Nope: fails with /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/9/libgomp.a(target.o): in function `gomp_target_init':
# (.text+0x360): warning: Using 'dlopen' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking

# So we have to disable both lcms and omp.

# This line is created by taking the line that libtool links dcraw_emu, and adding "-all-static" after "g++":

/bin/bash ./libtool --tag=CXX --mode=link g++ -all-static -g -O2 -o bin/dcraw_emu samples/bin_dcraw_emu-dcraw_emu.o lib/libraw.la /opt/homebrew/opt/jpeg/lib/libjpeg.a -lz -lm

/bin/bash ./libtool --tag=CXX --mode=link g++ -all-static -g -O2 -o bin/raw-identify samples/bin_raw_identify-raw-identify.o lib/libraw.la /opt/homebrew/opt/jpeg/lib/libjpeg.a -lz -lm

otool -L bin/dcraw_emu

# Should not reference anything in homebrew (like /opt/homebrew/opt/jpeg/lib/libjpeg.9.dylib)

strip bin/dcraw_emu
strip bin/raw-identify

# And we're done. #woot.
cp bin/dcraw_emu .../photostructure/tools/...
cp bin/raw-identify .../photostructure/tools/...
```
