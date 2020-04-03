#!/bin/bash

# Copyright © 2020, PhotoStructure Inc.

# Running this software indicates your agreement with to the terms of this
# license: <https://photostructure.com/eula>

# See <https://photostructure.com/server> for help.

function die() {
  printf "%s\n" "$1"
  exit 1
}

cd "$(dirname "$0")" || die "failed to cd"

# Propogate ctrl-c:
trap 'exit 130' INT

for i in git npx dcraw jpegtran sqlite3 ffmpeg ; do
  command -v $i >/dev/null || die "$i was not found. See <https://support.photostructure.com/photostructure-for-node>."
done

# Make sure we're always running the latest version:
git stash --quiet --include-untracked
git pull https://github.com/photostructure/photostructure-for-servers.git || die "git pull failed."

CFGDIR=$HOME/.config/PhotoStructure
mkdir -p "$CFGDIR"

# We can't put this in the current directory, because we always clean it out
# with git stash.
LASTVER="$CFGDIR/last-node-version.txt"

# If the version of node changed (or we're doing this the first time), rebuild:
if [ "$(cat "$LASTVER" /dev/null)" != "$(node -v)" ] ; then
  echo "Automatically rebuilding..."
  ./clean.sh
  node -v > "$LASTVER"
fi

argv=("$@")
run() {
  # We run `npx yarn install` because `npm install` provides no way to silence
  # all the dependency compilation warnings and spam.
  npx yarn install || die "Dependency installation failed.\nPlease visit <https://support.photostructure.com/photostructure-for-node> or\nsend an email to <support@photostructure.com> for help."

  ./photostructure "${argv[@]}" 2>&1 | tee start.log
  exit_code=$?
}

run

# If sharp has issues rebuilding, try again, but only once.

if grep -qE 'Something went wrong installing|Remove the "node_modules' start.log ; then
  echo "We'll try that again."
  ./clean.sh
  run
fi

if [ $exit_code -ne 0 ] ; then
  echo "Unexpected non-zero exit status. Please send the following to <mailto:support@photostructure.com> for assistance:"
  npx envinfo --binaries --languages --system --utilities
  cat start.log
fi
