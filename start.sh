#!/bin/bash

# Copyright © 2019, PhotoStructure Inc.

# Running this software indicates your agreement with to the terms of this
# license: <https://photostructure.com/eula>

# See <https://support.photostructure.com/photostructure-for-node> for help.

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
  echo "Rebuilding sharp and restarting..."
  rm -rf node_modules
  run
fi

if [ $exit_code -ne 0 ] ; then
  echo "Unexpected non-zero exit status. Please send the following to <mailto:support@photostructure.com> for assistance."
  set -x
  cat /etc/lsb-release
  which node
  node -v
  cat start.log
  set +x
fi
