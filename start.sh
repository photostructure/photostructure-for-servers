#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. >/dev/null 2>&1 && pwd )"

die() {
  echo $1
  exit 1
}

for i in git npx dcraw jpegtran sqlite3 ffmpeg ; do
  command -v $i >/dev/null || die "Please install $i."
done

(cd $ROOT && git pull) || die "git pull failed."

# We run `npx yarn install` instead of `npm install` because npm provides no way
# to silence all the installation spam and compilation warnings.
(cd $ROOT && npx yarn install) || die "Dependency installation failed.\nPlease see <https://support.photostructure.com/install-server>"

(cd $ROOT && ./photostructure $@)