#!/bin/bash -e

# Copyright © 2020, PhotoStructure Inc.

# Running this software indicates your agreement with to the terms of this
# license: <https://photostructure.com/eula>

# See <https://photostructure.com/server> for help.

function die {
  printf "%s\n" "$1"
  printf "See <https://photostructure.com/server/photostructure-for-node/> or\nsend an email to <support@photostructure.com> for help."
  exit 1
}

cd "$(dirname "$0")" || die "failed to cd"

# Propagate ctrl-c:
trap 'exit 130' INT

missingCommands=()

if [[ $(uname -o) = "Msys" ]] ; then
  PATH="$PATH:$(pwd)/tools/win-ia32/dcraw"
fi

for i in node git dcraw jpegtran sqlite3 ffmpeg ; do
  command -v $i >/dev/null || missingCommands+=("$i")
done

if [ ${#missingCommands[@]} -gt 0 ] ; then
  die "Please install the system prerequisites. (missing commands: ${missingCommands[*]})"
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
if [ ! -r "$PRIOR_VERSION" ] || [ "$(cat "$PRIOR_VERSION")" != "$EXPECTED_VERSION" ] ; then
  echo "Cleaning up prior builds before recompiling..."
  clean
  echo "$EXPECTED_VERSION" > "$PRIOR_VERSION"
fi

argv=("$@")

# We run `npx yarn install` because `npm install` provides no way to silence
# all the dependency compilation warnings and other console spam.
npx yarn install || die "Dependency installation failed."

./photostructure "${argv[@]}" 2>&1 | tee start.log
exit_code=$?

if [ $exit_code -ne 0 ] ; then
  echo "Unexpected non-zero exit status. Please send the following to <support@photostructure.com> for assistance:"
  npx envinfo --binaries --languages --system --utilities
  cat start.log
fi
