# Static build of `dcraw_emu`

To reproduce on a Raspberry Pi 4 running Debian Bullseye:

```sh
sudo apt install build-essential autogen autoconf libtool pkg-config libjpeg-dev zlib1g-dev

mkdir -p ~/src
cd ~/src
git clone https://github.com/LibRaw/LibRaw.git --depth 3
cd LibRaw
git checkout --force 6fffd414bfda63dfef2276ae07f7ca36660b8888 
autoreconf -fiv

./configure --enable-static --disable-lcms --disable-openmp

make -j4

# With lcms? Nope: fails with /usr/bin/ld: cannot find -llcms2

# With omp? Nope: fails with /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/9/libgomp.a(target.o): in function `gomp_target_init':
# (.text+0x360): warning: Using 'dlopen' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking

# So we have to disable both lcms and omp.

# This line is created by taking the line that libtool links dcraw_emu, and adding "-all-static" after "g++":

/bin/bash ./libtool  --tag=CXX   --mode=link g++ -all-static -g -O2   -o bin/dcraw_emu samples/bin_dcraw_emu-dcraw_emu.o lib/libraw.la -ljpeg -lz -lm

/bin/bash ./libtool  --tag=CXX   --mode=link g++ -all-static -g -O2   -o bin/raw-identify samples/bin_raw_identify-raw-identify.o lib/libraw.la -ljpeg -lz -lm

# ldd should report "not a dynamic executable:" (thanks to "-all-static")
ldd bin/dcraw_emu

# Before strip: 7.5M, after: 3.2M:
strip bin/dcraw_emu
strip bin/raw-identify

# And we're done. #woot.
cp bin/dcraw_emu ~/src/photostructure/tools/linux-arm/libraw
cp bin/raw-identify ~/src/photostructure/tools/linux-arm/libraw
```