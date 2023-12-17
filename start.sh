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
  printf "Please refer to https://photostructure.com/server/photostructure-for-node/ .\nYou can also visit https://forum.photostructure.com for help.\n\n"
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

# Windows needs `uname -o`, but that doesn't exist of macOS. macOS works with
# `uname -s`. Linux works with either -o or -s.
OS="$(uname -o 2>/dev/null || uname -s)"

if [ "$OS" = "Msys" ] || [ "$OS" = "Cygwin" ]; then
  IS_WINDOWS=1
else
  unset IS_WINDOWS
fi

if [ "$IS_WINDOWS" = 1 ]; then
  NODE="${NODE:-node.exe}" # < workaround for windows tty shenanigans
  PYTHON="${PYTHON:-py.exe}"
  PIP="${PIP:-pip.exe}"
  GIT="${GIT:-git.exe}"
else
  NODE="${NODE:-node}"
  PYTHON="${PYTHON:-python3}"
  PIP="${PIP:-"$PYTHON" -m pip}"
  GIT="${GIT:-git}"
fi

# We really just need node and git at this point:

for i in git "$NODE" "$PYTHON"; do
  command -v "$i" >/dev/null || die "Please install $i"
done

# Unfortunately, newer versions of python don't include distutils (which is
# part of setuptools), which is required in order to compile the
# platform-folders module.

# We don't want to freak out users with "<string>:1: DeprecationWarning: The
# distutils package is deprecated and slated for removal in Python 3.12. Use
# setuptools or check PEP 632 for potential alternatives", so we silence it
# with this environment variable:
export PYTHONWARNINGS="ignore::DeprecationWarning"

# We don't quote $PIP here because it may be a compound command (`python3 -m pip``)
"$PYTHON" -c "import distutils" || $PIP install setuptools || die "\"$PIP install setuptools\" failed."

# We can't just run `node --version` because that doesn't work in a subshell on
# Windows. YAY CROSS PLATFORM CODE IS FUN

NODE_VERSION="$(version "$("$NODE" -p process.versions.node)")"

# As of 20230930, Node.js versions older than 18 are End-of-life:
# https://nodejs.org/en/about/releases/
if [ "$NODE_VERSION" -lt "$(version "18.16.0")" ]; then
  die "Please install Node.js v18 or v20."
fi

# Add `timeout` to git commands if `timeout` is available, as external network
# may not be available (yet)

if command -v timeout >/dev/null; then

  timeout() {
    command timeout "$@"
  }
else
  timeout() {
    command "$@"
  }
fi

# set NOGIT=1 or PS_CHECK_UPDATES=none to disable auto-update:

if [ "$NOGIT" != "1" ] && [ "$PS_CHECK_UPDATES" != "none" ]; then
  echo "$GIT" stash --include-untracked

  # This may be running at system startup, and network may not be available
  # yet--try, but timeout after a minute.

  # `git pull` ensures we're always running the latest version of this branch:
  if command -v timeout >/dev/null; then
    timeout 60 "$GIT" pull || echo "$GIT pull timed out"
  else
    "$GIT" pull || die "git pull failed."
  fi
fi

clean() {
  npx yarn cache clean
  if [ "$IS_WINDOWS" = 1 ]; then
    rm -rf node_modules "$APPDATA/npm-cache/_libvips" "$LOCALAPPDATA/node-gyp"
  else
    rm -rf node_modules "$HOME/.npm/_libvips" "$HOME/.node-gyp"
  fi
}

if [ "$IS_WINDOWS" = 1 ]; then
  PS_CONFIG_DIR=${PS_CONFIG_DIR:-$APPDATA/PhotoStructure}
else
  PS_CONFIG_DIR=${PS_CONFIG_DIR:-$HOME/.config/PhotoStructure}
fi
mkdir -p "$PS_CONFIG_DIR"

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

# This is used by the version health check--we'll suggest you move to a more
# stable branch (like "main" instead of "beta") if the same version is
# available on that branch.
PS_UPDATE_CHANNEL=$(git rev-parse --abbrev-ref HEAD)
export PS_UPDATE_CHANNEL

# We used to `tee` to a runlog, but by propagating ctrl-c, the tee would get
# killed and shutdown messages would be omitted from stdout.
"$NODE" ./photostructure "${argv[@]}"
