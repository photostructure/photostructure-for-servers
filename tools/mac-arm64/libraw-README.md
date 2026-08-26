# LibRaw `dcraw_emu` and `raw-identify`

Built locally for arm64 from the LibRaw
[`0.22.2`](https://github.com/LibRaw/LibRaw/releases/tag/0.22.2) release.

Source archive:

- URL: <https://github.com/LibRaw/LibRaw/archive/refs/tags/0.22.2.tar.gz>
- SHA-256: `627928088300ecde6ca91ffd202e189203f04ad61ad12f0fe9dc57b9a7a0fb3c`

These executables were compiled locally, not downloaded as binaries.

## Reproduce

```sh
brew install autogen autoconf automake libtool pkg-config cmake nasm

SCRATCH="$(mktemp -d /tmp/phstr-libraw-arm64-XXXXXX)"
LIBRAW_VERSION="0.22.2"
JPEG_VERSION="3.2.0"

curl -fsSL -o "$SCRATCH/LibRaw.tar.gz" \
  "https://github.com/LibRaw/LibRaw/archive/refs/tags/$LIBRAW_VERSION.tar.gz"
curl -fsSL -o "$SCRATCH/libjpeg-turbo.tar.gz" \
  "https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/$JPEG_VERSION/libjpeg-turbo-$JPEG_VERSION.tar.gz"
tar -xzf "$SCRATCH/LibRaw.tar.gz" -C "$SCRATCH"
tar -xzf "$SCRATCH/libjpeg-turbo.tar.gz" -C "$SCRATCH"

LIBRAW_SOURCE="$SCRATCH/LibRaw-$LIBRAW_VERSION"
JPEG_SOURCE="$SCRATCH/libjpeg-turbo-$JPEG_VERSION"
JPEG_BUILD="$SCRATCH/jpeg-arm64"
LIBRAW_BUILD="$SCRATCH/libraw-arm64"

cmake -S "$JPEG_SOURCE" -B "$JPEG_BUILD" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_ARCHITECTURES=arm64 \
  -DENABLE_SHARED=FALSE \
  -DENABLE_STATIC=TRUE
cmake --build "$JPEG_BUILD" --parallel 8

cd "$LIBRAW_SOURCE"
autoreconf -fiv
mkdir -p "$LIBRAW_BUILD"
cd "$LIBRAW_BUILD"
env CC=/usr/bin/clang CXX=/usr/bin/clang++ \
  CPPFLAGS="-I$JPEG_SOURCE/src -I$JPEG_BUILD" \
  CFLAGS="-arch arm64" \
  CXXFLAGS="-arch arm64" \
  LDFLAGS="-arch arm64 -L$JPEG_BUILD" \
  "$LIBRAW_SOURCE/configure" \
    --enable-static --disable-shared --enable-jpeg \
    --disable-lcms --disable-openmp
make -j8 LIBS="-ljpeg -lz -lm -lc++"
strip bin/dcraw_emu bin/raw-identify
```

## Verification

- `dcraw_emu` SHA-256: `7171c6e63a9f21796554fdcabb05e14704f160d2cef8a9d6dae0c741a955fcb7`
- `raw-identify` SHA-256: `c1219c228e5881e47f25542f4b60f99a33275232582f03a49f5859ba6620ae7c`
- Both are arm64 Mach-O executables whose dynamic dependencies are only
  `/usr/lib/libz.1.dylib`, `/usr/lib/libSystem.B.dylib`, and
  `/usr/lib/libc++.1.dylib`.
- `raw-identify examples/Raw/RAW_NIKON_D70.NEF` identified a Nikon D70 image.
- `dcraw_emu -h -w` decoded that image to a valid 1007x1519 Netpbm pixmap.
