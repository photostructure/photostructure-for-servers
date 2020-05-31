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

# Propogate ctrl-c:
trap 'exit 130' INT

missingCommands=()

for i in node git dcraw jpegtran sqlite3 ffmpeg ; do
  command -v $i >/dev/null || missingCommands+=("$i")
done

if [ ${#missingCommands[@]} -gt 0 ] ; then
  die "Please install the system prerequisites. (missing commands: ${missingCommands[*]})"
fi

# Make sure we're always running the latest version:
git stash --quiet --include-untracked
git pull https://github.com/photostructure/photostructure-for-servers.git || die "git pull failed."

CFGDIR=~/.config/PhotoStructure
mkdir -p "$CFGDIR"

function clean {
  rm -rfI node_modules ~/.electron ~/.electron-gyp ~/.npm/_libvips ~/.node-gyp ~/.cache/yarn/*/*sharp*
}

# We can't put this in the current directory, because we always clean it out
# with git stash.
PRIOR_VERSION="$CFGDIR/prior-version.json"
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
