# Static build of `dcraw_emu` and `raw-identify`

To reproduce on Ubuntu 20.04 LTS:

```sh
sudo apt install build-essential autogen autoconf libtool pkg-config libjpeg-dev zlib1g-dev

cd /tmp
rm -rf LibRaw
git clone https://github.com/LibRaw/LibRaw.git
cd LibRaw
git checkout --force 6fffd414bfda63dfef2276ae07f7ca36660b8888

# wget https://www.libraw.org/data/LibRaw-0.20.2.tar.gz
# sha256sum should say "OK":
# echo dc1b486c2003435733043e4e05273477326e51c3ea554c6864a4eafaff1004a6  LibRaw-0.20.2.tar.gz | sha256sum --check
# tar xvzf LibRaw-0.20.2.tar.gz
# cd LibRaw-0.20.2

autoreconf -fiv

./configure --enable-static --disable-lcms --disable-openmp

make -j$(nproc)

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
cp bin/dcraw_emu ~/src/photostructure/tools/linux-x64/
cp bin/raw-identify ~/src/photostructure/tools/linux-x64/
```