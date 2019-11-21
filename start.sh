#!/bin/bash

cd "$(dirname "$0")"

# Propogate ctrl-c:
trap 'exit 130' INT

die() {
  echo $1
  exit 1
}

for i in git npx dcraw jpegtran sqlite3 ffmpeg ; do
  command -v $i >/dev/null || die "$i was not found. See <https://support.photostructure.com/install-server>."
done

# Make sure we've got the latest:
git pull || die "git pull failed."

# We run `npx yarn install` instead of `npm install` because npm provides no way
# to silence all the installation spam and compilation warnings.
npx yarn install || die "Dependency installation failed.\nPlease visit <https://support.photostructure.com/install-server> or\nsend an email to <support@photostructure.com> for help."

./photostructure $@