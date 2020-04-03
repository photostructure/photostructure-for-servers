# PhotoStructure™ for Servers

PhotoStructure is your new home for all your photos and videos. Installation
should only take a couple minutes.

Your use of PhotoStructure is governed by the [End-user license
agreement](https://photostructure.com/eula/).

## Installation for Ubuntu

**Only tested and supported on x64 Ubuntu LTS 18.04.**

1. Install the LTS version of [Node.js](https://nodejs.org). We recommend [using
   the .deb
   installation](https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions),
   as your system will then apply security updates with other system updates.
   You may see performance problems if you use the snap version.
2. Install system prerequisites:

```sh
sudo apt-get update;
sudo apt-get upgrade;
sudo apt-get install build-essential dcraw ffmpeg libjpeg-turbo-progs perl python2.7-dev sqlite3;
```

_Optional:_ If you need `.heic` support, you'll need to:

3. Install the compilation dependencies:

```sh
sudo apt install build-essential glib2.0-dev libexpat1-dev libgsf-1-dev libheif-dev libjpeg-turbo8-dev liblcms2-dev libpng-dev libtiff5-dev libwebp-dev pkg-config;
```

4. [Build `libvips` with these instructions](#build-libvips)
5. Complete the `libvips` installation by running

```sh
sudo ldconfig;
```

6. You can now [start PhotoStructure](#start).

## Installation for macOS

**Only tested and supported on High Sierra, Mojave, and Catalina.**

1. Install the LTS version of [Node.js](https://nodejs.org)
2. Install [Xcode](https://developer.apple.com/xcode/download/)
3. Install [homebrew](https://brew.sh/)
4. Install system prerequisites:

```sh
xcode-select --install;
sudo xcode-select --reset;
brew upgrade;
brew install dcraw ffmpeg jpeg-turbo sqlite3;
```

_Optional:_ If you need `.heic` support, you'll need to:

5. Install the compilation dependencies:

```sh
brew install giflib glib libjpeg-turbo libexif libheif libtiff little-cms2 mozjpeg webp pkg-config;
```

6. [Build `libvips` with these instructions](#build-libvips)
7. Complete the `libvips` installation by running

```sh
sudo update_dyld_shared_cache;
```

8. **And then reboot your mac.**

_You must reboot before continuing (due to the way the dyld cache works)._

If you skipped these last steps because you did not need `.heic` support, you don't have to reboot.

9. You can now [start PhotoStructure](#start).

<a id="build-libvips"></a>

## _Optional step:_ Build `libvips`

If you need `.heic` support, you'll need a custom build of the `libvips` library.
After you installing compilation dependencies (see above), run:

```sh
VIPS=~/src/vips;
VER=8.9.1;
TGZ=vips-${VER}.tar.gz;
URL=https://github.com/libvips/libvips/releases/download/v${VER}/${TGZ};
mkdir -p $VIPS;
cd $VIPS;
curl -Lo- $URL > $TGZ;
tar -xzf $TGZ;
cd vips-$VER;
./configure;
make;
sudo make install;
```

And then run either `ldconfig` (on Linux) or `update_dyld_shared_cache` (on macOS), and then reboot (on macOS).

See <https://libvips.github.io/libvips/install.html#building-libvips-from-a-source-tarball> for more details.

<a id="start"></a>

## Start PhotoStructure

The `./start.sh` script verifies that node, git, and other required tools are
installed, pulls the latest build from `master`, asks `yarn` to install
dependencies, and finally launches PhotoStructure.

You can use `./start.sh --help` to see more detailed usage information.

**BY RUNNING THIS SOFTWARE, YOU ARE AGREEING TO ALL TERMS IN THE
[LICENSE](https://photostructure.com/terms/eula/)**. It's quite short. Please
read it.

```sh
./start.sh
```

The process should emit a localhost URL for you to open with a browser. Current
versions of Chrome, Firefox, and Safari are supported.

Please see <https://photostructure.com/server> for more instructions on
installation and running this software, including instructions for running under
Docker.
