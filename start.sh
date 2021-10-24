#!/bin/bash -e

# Copyright © 2021, PhotoStructure Inc.

# BY RUNNING THIS SOFTWARE YOU AGREE TO ALL THE TERMS OF THIS LICENSE:
# <https://photostructure.com/eula>

# Run `./start.sh --help` and `./start.sh main --help` for usage.

# See <https://photostructure.com/server> for general instructions and
# visit <https://forum.photostructure.com/> for support.

# SYNTAX NOTE TO FUTURE SELF:
# function foo {...} # < doesn't work with /bin/sh
# foo() {...} # < works with dash and bash

die() {
  printf "%s\n" "$1"
  printf "Please refer to <https://photostructure.com/server/photostructure-for-node/>.\nYou can also visit <https://forum.photostructure.com> for help.\n\n"
  exit 1
}

# Turns a SemVer-esque version into a string that can be asciibetically sorted
# or compared: "1.2.3" becomes "0001000200030000" (we currently only check tools
# that need to pad to 2, but to support CalVer (2021.08.18) and Chrome
# (92.0.4515.131) we pad to 4.
version() {
  # Support "1.2", "1.2.3", "1.2.3.4", and "01.23.001":
  echo "$@" | awk -F. '{ printf("%04d%04d%04d%04d\n",$1,$2,$3,$4); }'
}

cd "$(dirname "$0")" || die "failed to cd"

# Propagate ctrl-c:
trap 'exit 130' INT

NODE="node"

# Windows needs `uname -o`, but that doesn't exist of macOS. macOS works with
# `uname -s`. Linux works with either -o or -s.
OS="$(uname -o 2>/dev/null || uname -s)"

if [ "$OS" = "Darwin" ]; then
  if [ "$(version "$(uname -r)")" -lt "$(version 18.7)" ]; then
    echo "WARNING: PhotoStructure for Servers is only supported on macOS Mojave and later."
  fi
elif [ "$OS" = "Msys" ] || [ "$OS" = "Cygwin" ]; then
  NODE="node.exe" # < workaround for windows tty shenanigans

elif [ "$OS" = "Linux" ] || [ "$OS" = "GNU/Linux" ]; then
  if [ -r /etc/os-release ]; then
    # If we're on Ubuntu...
    # (we source into a subshell to avoid inadvertent variable pollution)
    if [ "$(
      source /etc/os-release
      echo "$NAME"
    )" == "Ubuntu" ]; then
      OS_VER=$(
        source /etc/os-release
        version "$VERSION_ID"
      )
      if [ "$OS_VER" -lt "$(version "18.04.0")" ]; then
        printf "Sorry, this version of Ubuntu isn't supported. Please use a Docker build, or upgrade to 20.04 or later.\nSee <https://photostructure.com/server/photostructure-for-docker/>\n\n"
        echo exit 1
      elif [ "$OS_VER" -lt "$(version "20.04.0")" ]; then
        printf "WARNING: This version of Ubuntu does not support HEIF-encoded images.\nPlease use PhotoStructure for Docker or upgrade to Ubuntu 20.04 or later.\n<https://photostructure.com/server/photostructure-for-docker/>\n\n"
      fi
    fi
  else
    echo "WARNING: this isn't a supported platform."
  fi
else
  echo "WARNING: this isn't a supported platform."
fi

# Version 1.0.0 includes all the binaries from PhotoStructure for Desktop in
# PhotoStructure for Node because the system libraries (like libraw and sqlite)
# are probably out of date.

# We really just need node and git at this point:

for i in git $NODE; do
  command -v $i >/dev/null || die "Please install $i"
done

# And warn people if they don't have ffmpeg:

if ! command -v ffmpeg >/dev/null; then
  printf "WARNING: ffmpeg is required for video support.\nSee <https://photostructure.com/getting-started/video-support/#ubuntu-installation>\n\n"
fi

# We can't just run `node --version` because that doesn't work in a subshell on
# Windows. CROSS PLATFORM CODE IS FUN

NODE_VERSION="$(version "$($NODE -p process.versions.node)")"

# Node 14 has (many!) important security and performance improvements

if [ "$NODE_VERSION" -lt "$(version "14.16.0")" ]; then
  die "Please install Node.js v14.16.0 or later"
fi

# set NOGIT=1 to disable auto-update:

if [[ "$NOGIT" != "1" ]]; then
  # Make sure we're always running the latest version of our branch
  git stash --include-untracked
  git pull || die "git pull failed."
fi

PS_CONFIG_DIR=${PS_CONFIG_DIR:-$HOME/.config/PhotoStructure}
mkdir -p "$PS_CONFIG_DIR"

clean() {
  # NOTE: even if $HOME isn't set, these paths from root wouldn't be terrible to delete:
  rm -rf node_modules "$HOME/.electron" "$HOME/.electron-gyp" "$HOME/.npm/_libvips" "$HOME/.node-gyp" "$HOME/.cache/yarn/*/*sharp*"
}

# We can't put this in the current directory, because we always clean it out
# with git stash.
PRIOR_VERSION="$PS_CONFIG_DIR/prior-version.json"
EXPECTED_VERSION="{ \"node\": \"$NODE_VERSION\", \"photostructure\": $(cat VERSION.json) }"
if [ ! -r "$PRIOR_VERSION" ] || [ "$(cat "$PRIOR_VERSION")" != "$EXPECTED_VERSION" ]; then
  echo "Cleaning up prior builds before recompiling..."
  clean
  echo "$EXPECTED_VERSION" >"$PRIOR_VERSION"
fi

argv=("$@")

# We run `npx yarn install` because `npm install` provides no way to silence
# all the dependency compilation warnings and other console spam.

# Adding --silent hides the potentially scary "...is incompatible with this
# module..." messages. <https://forum.photostructure.com/t/886?u=mrm>
npx yarn install --silent || die "Dependency installation failed."

# We used to `tee` to a runlog, but by propagating ctrl-c, the tee would get
# killed and shutdown messages would be omitted from stdout.
$NODE ./photostructure "${argv[@]}"
exit_code=$?

if [ $exit_code -ne 0 ]; then
  echo "If this error persists, please see <https://forum.photostructure.com>."
fi
