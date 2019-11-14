# PhotoStructure™ for Servers

PhotoStructure is your new home for all your photos and videos, and installation
should only take a couple minutes.

Your use of PhotoStructure is governed by the [End-user license agreement](./LICENSE.md).

## Quick install for Debian/Ubuntu

**PhotoStructure is only tested and supported on x64 Ubuntu LTS 18.04.**

1. Install the LTS version of [Node.js](https://nodejs.org)
2. Install system prerequisites:

```sh
$ sudo apt-get update && sudo apt-get upgrade
$ sudo apt-get install ffmpeg sqlite3 dcraw libjpeg-turbo-progs perl build-essential python2.7-dev
```

## Quick install for macOS

**PhotoStructure is only tested and supported on High Sierra, Mojave, and Catalina.**

1. Install the LTS version of [Node.js](https://nodejs.org)
2. Install [Xcode](https://developer.apple.com/xcode/download/)
3. Install [homebrew](https://brew.sh/)
4. Install system prerequisites:

```sh
$ brew install ffmpeg sqlite3 dcraw jpeg
$ xcode-select --install
$ sudo xcode-select --reset
```

5. (Optional): Make sure you're running the latest version of all your
   brew-installed packages:

```sh
$ brew upgrade outdated
```

## Start PhotoStructure

The `start.sh` script verifies that node and git is installed, pulls the latest
build from `master`, asks `yarn` to install dependencies, and finally launches
PhotoStructure. You can use `--help` to see more detailed usage information.

**BY RUNNING THIS SOFTWARE, YOU ARE AGREEING TO ALL TERMS IN THE [LICENSE](./LICENSE.md)**. It's quite short. Please read it.

```sh
./start.sh
```

Please see <https://support.photostructure.com/install-server> for more
instructions on installation and running this software.
