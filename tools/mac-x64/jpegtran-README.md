# jpegtran

Part of the [libjpeg-turbo](https://www.libjpeg-turbo.org/), provides lossless JPEG operations.

```sh
brew install cmake nasm
cd /tmp
export VER=3.1.2
curl -L https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/${VER}/libjpeg-turbo-${VER}.tar.gz | tar xz
cd libjpeg-turbo-${VER}
cmake -DCMAKE_OSX_ARCHITECTURES=x86_64 .
make jpegtran-static
strip jpegtran-static
```

Verify we did it:

```
% file jpegtran-static
jpegtran-static: Mach-O 64-bit executable x86_64
% otool -L jpegtran-static
jpegtran-static:
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1356.0.0)
```

Copy into tools:

```sh
cp jpegtran-static ~/src/photostructure/tools/mac-x64/jpegtran
```
