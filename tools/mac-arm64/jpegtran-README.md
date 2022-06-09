# jpegtran

Part of the [libjpeg-turbo](https://www.libjpeg-turbo.org/), provides lossless JPEG operations.

```sh
brew install cmake nasm wget 
cd ~/src
export VER=2.1.3
wget https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/tags/${VER}.tar.gz
tar xvzf ${VER}.tar.gz
cd libjpeg-turbo-${VER}
cmake .
make jpegtran-static
strip jpegtran-static
```

Verify we did it:

```
mrm@m1 libjpeg-turbo-2.1.3 % file jpegtran-static 
jpegtran-static: Mach-O 64-bit executable arm64
mrm@m1 libjpeg-turbo-2.1.3 % otool -L jpegtran-static 
jpegtran-static:
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1311.100.3)
```

Copy into tools:

```sh
arch=$(node -e "console.log(require('os').arch())")
cp jpegtran-static ~/src/photostructure/tools/mac-$arch/jpegtran
```
