#!/bin/bash -e

# Copyright © 2020, PhotoStructure Inc.

# Running this software indicates your agreement with to the terms of this
# license: <https://photostructure.com/eula>

# See <https://photostructure.com/server> for help.

function die {
  printf "%s\n" "$1"
  printf "See <https://support.photostructure.com/photostructure-for-node> or\nsend an email to <support@photostructure.com> for help."
  exit 1
}

cd "$(dirname "$0")" || die "failed to cd"

# Propogate ctrl-c:
trap 'exit 130' INT

for i in node git npx dcraw jpegtran sqlite3 ffmpeg ; do
  command -v $i >/dev/null || die "Please install $i."
done

# Make sure we're always running the latest version:
git stash --quiet --include-untracked
git pull https://github.com/photostructure/photostructure-for-servers.git || die "git pull failed."

CFGDIR=~/.config/PhotoStructure
mkdir -p "$CFGDIR"

function clean {
  # this is safe, no need to prompt:
  rm -rf node_modules
  # eh, let's ask them about these:
  rm -rfI ~/.electron ~/.electron-gyp ~/.npm/_libvips ~/.node-gyp ~/.cache/yarn/*/*sharp*
}

# We can't put this in the current directory, because we always clean it out
# with git stash.
PRIOR_NODE="$CFGDIR/last-node-version.txt"
if [ -r "$PRIOR_NODE" ] && [ "$(cat "$PRIOR_NODE")" != "$(node -v)" ] ; then
  echo "Node has updated. Automatically rebuilding..."
  clean
  node -v > "$PRIOR_NODE"
fi

PRIOR_VERSION="$CFGDIR/last-VERSION.json"
# If the version of node changed (or we're doing this the first time), rebuild:
if [ -r "$PRIOR_VERSION" ] ; then
  prior=$(cat "$PRIOR_VERSION")
  if [ "$prior" != "$(cat VERSION.json)" ] ; then
    echo "New version of PhotoStructure. Automatically rebuilding..."
    clean
    cp VERSION.json "$PRIOR_VERSION"
  fi
fi

argv=("$@")

# We run `npx yarn install` because `npm install` provides no way to silence
# all the dependency compilation warnings and spam.
npx yarn install || die "Dependency installation failed."

./photostructure "${argv[@]}" 2>&1 | tee start.log
exit_code=$?

if [ $exit_code -ne 0 ] ; then
  echo "Unexpected non-zero exit status. Please send the following to <support@photostructure.com> for assistance:"
  npx envinfo --binaries --languages --system --utilities
  cat start.log
fi
