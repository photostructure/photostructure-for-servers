# `jpegtran`

`jpegtran` provides lossless JPEG transformations and is built locally from
[libjpeg-turbo 3.2.0](https://github.com/libjpeg-turbo/libjpeg-turbo/releases/tag/3.2.0).

Source archive:

- URL: <https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/3.2.0/libjpeg-turbo-3.2.0.tar.gz>
- SHA-256: `6f30092cef9fb839779646608f4ee14ae3cbac989c47fa05e841b0841f09878e`

This executable was compiled locally, not downloaded as a binary.

## Reproduce

```sh
brew install cmake nasm
SCRATCH="$(mktemp -d /tmp/phstr-jpegtran-x64-XXXXXX)"
VERSION="3.2.0"
curl -fsSL -o "$SCRATCH/libjpeg-turbo.tar.gz" \
  "https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/$VERSION/libjpeg-turbo-$VERSION.tar.gz"
tar -xzf "$SCRATCH/libjpeg-turbo.tar.gz" -C "$SCRATCH"
cmake -S "$SCRATCH/libjpeg-turbo-$VERSION" -B "$SCRATCH/build" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_ARCHITECTURES=x86_64 \
  -DENABLE_SHARED=FALSE \
  -DENABLE_STATIC=TRUE
cmake --build "$SCRATCH/build" --parallel 8
ctest --test-dir "$SCRATCH/build" --output-on-failure
strip "$SCRATCH/build/jpegtran-static"
```

## Verification

- SHA-256: `7d8b299f282284b25fa847d6cf556c7945551d690d1d0cb41204da76a5478fbc`
- `jpegtran -version`: `libjpeg-turbo version 3.2.0 (build 20260824)`
- x86_64 Mach-O executable with only `/usr/lib/libSystem.B.dylib` as a dynamic
  dependency.
- All 332 upstream CTest cases passed under Rosetta.
- Under Rosetta, a lossless 90-degree rotation of
  `examples/orientation/Landscape_0.jpg` produced a valid 1200x1800 JPEG.
