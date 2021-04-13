#!/bin/sh

# Tell PhotoStructure we're running under docker:
export PS_IS_DOCKER="1"

# Node is installed in /usr/local/bin:
export PATH="${PATH}:/usr/local/bin"

# Accept either UID or PUID:
export UID=${UID:-${PUID:-1000}}
# Accept either GID or PGID:
export GID=${GID:-${PGID:-1000}}

# Are we already not root, or are they forcing PhotoStructure to run as root?
# RUNNING PHOTOSTRUCTURE AS ROOT IS NOT RECOMMENDED.

if [ "$UID" = "0" ] || [ "$(id --real --user)" != "0" ]; then
  # They want to run as root or started docker with --user, so we shouldn't do
  # any usermod/groupmod/su shenanigans:
  /usr/local/bin/node /ps/app/photostructure "$@"
else
  # Change the phstr user and group to match UID/GID.
  # (we don't care about "usermod: no changes"):
  usermod --non-unique --uid "$UID" phstr >/dev/null
  groupmod --non-unique --gid "$GID" phstr

  # Always make sure the settings, opened-by, and models directories are
  # writable by phstr:
  chown --silent --recursive phstr:phstr /ps/library/.photostructure/settings.toml /ps/library/.photostructure/opened-by /ps/library/.photostructure/models

  # Help for prior users that ran as root:
  if [ "$PS_FIX_PERMISSIONS" = "1" ]; then
    echo
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "!!! recursively changing file ownership in all /ps/* volumes !!!"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo
    echo "Hit ctrl-c in the next 10 seconds to cancel running the following:"
    echo "# chown --recursive $UID:$GID /ps/*"
    sleep 10s
    chown --recursive $UID:$GID /ps
  fi

  # - Start photostructure as user phstr instead of root:
  su --preserve-environment phstr --command "/usr/local/bin/node /ps/app/photostructure $*"
fi
