#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. >/dev/null 2>&1 && pwd )"

die() {
  echo $1
  exit 1
}

for i in git npx dcraw jpegtran sqlite3 ffmpeg ; do
  command -v $i >/dev/null || die "$i was not found. See <https://support.photostructure.com/install-server>."
done

# Make sure we've got the latest:
(cd $ROOT && git pull) || die "git pull failed."

# We run `npx yarn install` instead of `npm install` because npm provides no way
# to silence all the installation spam and compilation warnings.
(cd $ROOT && npx yarn install) || die "Dependency installation failed.\nPlease visit <https://support.photostructure.com/install-server> or\nsend an email to <support@photostructure.com> for help."

(cd $ROOT && ./photostructure $@)