#!/bin/bash -e

# Copyright © 2021, PhotoStructure Inc.

# BY RUNNING THIS SOFTWARE YOU AGREE TO ALL THE TERMS OF THIS LICENSE:
# <https://photostructure.com/eula>

# (we use arrays in this script, so we have to use bash instead of sh)

# See <https://photostructure.com/server> for instructions and
# <https://forum.photostructure.com/> for support.

function die {
  printf "%s\n" "$1"
  printf "Please refer to <https://photostructure.com/server/photostructure-for-node/>.\nYou can also visit <https://forum.photostructure.com> for help.\n\n"
  exit 1
}

function version {
  echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

cd "$(dirname "$0")" || die "failed to cd"

# Propagate ctrl-c:
trap 'exit 130' INT

# macOS doesn't have -o, because macOS.
if [[ "$(uname)" =~ "Darwin" ]]; then
  PATH="$PATH:$(pwd)/tools/mac-x64/libraw"

elif [ "$(uname -o 2>/dev/null)" = "Msys" ]; then
  PATH="$PATH:$(pwd)/tools/win-x64/libraw"

elif [[ "$(uname -o 2>/dev/null)" =~ "Linux" ]]; then
  PATH="$PATH:$(pwd)/tools/linux-x64/libraw"
  if [ -r /etc/os-release ]; then
    # If we're on Ubuntu...
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

missingCommands=()

for i in git ffmpeg; do
  command -v $i >/dev/null || missingCommands+=("$i")
done

if [ ${#missingCommands[@]} -gt 0 ]; then
  die "Please install these commands: ${missingCommands[*]}"
fi

if ! command -v ffmpeg >/dev/null; then
  printf "WARNING: ffmpeg is required for video support.\nSee <https://photostructure.com/getting-started/video-support/#ubuntu-installation>\n\n"
fi

if [ "$(version "$(node --version)")" -lt "$(version "14.16.0")" ]; then
  die "Please install Node.js v14.16.0 or later"
fi

# Make sure we're always running the latest version of our branch
git stash --include-untracked
git pull || die "git pull failed."

PS_CONFIG_DIR=${PS_CONFIG_DIR:-$HOME/.config/PhotoStructure}
mkdir -p "$PS_CONFIG_DIR"

function clean {
  rm -rf node_modules "$HOME/.electron" "$HOME/.electron-gyp" "$HOME/.npm/_libvips" "$HOME/.node-gyp" "$HOME/.cache/yarn/*/*sharp*"
}

# We can't put this in the current directory, because we always clean it out
# with git stash.
PRIOR_VERSION="$PS_CONFIG_DIR/prior-version.json"
EXPECTED_VERSION="{ \"node\": \"$(node -v)\", \"photostructure\": $(cat VERSION.json) }"
if [ ! -r "$PRIOR_VERSION" ] || [ "$(cat "$PRIOR_VERSION")" != "$EXPECTED_VERSION" ]; then
  echo "Cleaning up prior builds before recompiling..."
  clean
  echo "$EXPECTED_VERSION" >"$PRIOR_VERSION"
fi

argv=("$@")

# We run `npx yarn install` because `npm install` provides no way to silence
# all the dependency compilation warnings and other console spam.
npx yarn install || die "Dependency installation failed."

./photostructure "${argv[@]}" 2>&1 | tee start.log
exit_code=$?

if [ $exit_code -ne 0 ]; then
  echo "Unexpected non-zero exit status."
  echo
  echo "Please post to <https://forum.photostructure.com/c/support/6> with the error and the following information:"
  set +x
  npx envinfo --binaries --languages --system --utilities
  cat start.log
fi
