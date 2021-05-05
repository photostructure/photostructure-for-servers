#!/bin/sh

# Copyright © 2021, PhotoStructure Inc.

# BY RUNNING THIS SOFTWARE YOU AGREE TO ALL THE TERMS OF THIS LICENSE:
# <https://photostructure.com/eula>

# See <https://photostructure.com/server> for instructions and
# <https://forum.photostructure.com/> for support.

# Propagate ctrl-c while we're still in this script:
trap 'exit 130' INT

# Tell PhotoStructure that we're running in a docker container:
export PS_IS_DOCKER="1"

# Node was already installed into /usr/local/bin:
export PATH="${PATH}:/usr/local/bin"

# Prior to v1.0, PhotoStructure for Docker defaulted to running as root. To
# prevent upgrades from failing due to permission issues, let's default the
# userid to match the current owner of the system settings.toml file. 

# This default value will be overridden if UID, GID, PUID, or PGID are set.

# If the file is missing, we default to 1000 for both the UID and GID, which are
# the default ids given to the first non-system user (at least in Ubuntu and
# Fedora).

DEFAULT_UID=$(stat -c %u /ps/config/settings.toml 2>/dev/null || echo 1000)
DEFAULT_GID=$(stat -c %g /ps/config/settings.toml 2>/dev/null || echo 1000)

# Accept either UID or PUID. We default to 0 (root) 
export UID=${UID:-${PUID:-${DEFAULT_UID}}}

# Accept either GID or PGID:
export GID=${GID:-${PGID:-${DEFAULT_GID}}}

if [ "$*" = "sh" ]; then
  # Let the user shell into the container:
  true
elif [ "$UID" = "0" ] || [ "$(id --real --user)" != "0" ]; then
  # They either want to run as root, or started docker with --user, so we
  # shouldn't do any usermod/groupmod/su shenanigans.

  # We `exec` to replace the process with node so it gets all signals sent to
  # the container:
  exec /usr/local/bin/node /ps/app/photostructure "$@"
else
  # Change the phstr user and group to match UID/GID.
  # (we don't care about "usermod: no changes"):
  usermod --non-unique --uid "$UID" phstr >/dev/null
  groupmod --non-unique --gid "$GID" phstr

  # Always make sure the settings, opened-by, and models directories are
  # writable by phstr:
  chown --silent --recursive phstr:phstr /ps/library/.photostructure/settings.toml /ps/library/.photostructure/opened-by /ps/library/.photostructure/models

  # Help prior users that previously ran as root:
  if [ "$PS_FIX_DOCKER_PERMISSIONS" = "1" ]; then
    echo "Recursively changing ownership of your library to $UID:$GID. This may take a while..." 
    chown --recursive phstr:phstr /ps
  fi

  # Start photostructure as user phstr instead of root. 
  
  # We `exec` to replace the process with node so it gets all signals sent to
  # the container:
  exec su --preserve-environment phstr --command "/usr/local/bin/node /ps/app/photostructure $*"
fi
