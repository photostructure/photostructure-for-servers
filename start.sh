#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. >/dev/null 2>&1 && pwd )"

die() {
  echo $1
  popd
  exit 1
}

command -v git || die "Please install git."
command -v npx || die "Please install Node.js."

pushd $ROOT || die "Failed to change directories into $ROOT."

git pull || die "git pull failed."

# We run `npx yarn install` instead of `npm install` because npm provides no way
# to silence all the installation spam and compilation warnings.
npx yarn install || die "Dependency installation failed.\nPlease see <https://support.photostructure.com/install-server>"
./photostructure $@

popd