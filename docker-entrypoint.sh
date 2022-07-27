#!/bin/sh

# Copyright © 2022, PhotoStructure Inc.

# BY RUNNING THIS SOFTWARE YOU AGREE TO ALL THE TERMS OF THIS LICENSE:
# <https://photostructure.com/eula>

# See <https://photostructure.com/server> for instructions and
# <https://forum.photostructure.com/> for support.

# Propagate ctrl-c while we're still in this script:
trap 'exit 130' INT

# `node` is installed in /usr/local/bin:
export PATH="${PATH}:/usr/local/bin:/ps/app:/ps/app/bin"

# Prior to v1.0, PhotoStructure for Docker defaulted to running as root. To
# prevent upgrades from failing due to permission issues, let's default the UID
# and GID to match the current owner of the system settings.toml file.

# Prior to v2.1-alpha.4, PhotoStructure for Docker accepted both "UID" and
# "PUID" environment variables, but this can cause issues with some shells
# (like bash) that treat $UID as a read-only value. This script now only looks
# at $PUID and $PGID -- if your docker container setup set the environment
# variable $UID, please change it to $PUID.

# If $PUID or $PGID is not set, PhotoStructure will default to use the current
# owner of the system settings or library settings files. If both of those are
# missing, we default to 1000 for both PUID and PGID, which are the default
# ids given to the first non-system user (at least in Ubuntu and Fedora).

# See <https://photostructure.com/go/puid> for more details.

DEFAULT_UID=$(stat -c %u /ps/config/settings.toml 2>/dev/null || stat -c %u /ps/library/.photostructure/settings.toml 2>/dev/null || echo 1000)
DEFAULT_GID=$(stat -c %g /ps/config/settings.toml 2>/dev/null || stat -c %g /ps/library/.photostructure/settings.toml 2>/dev/null || echo 1000)

# Accept either UID or PUID:
export PUID="${PUID:-${DEFAULT_UID}}"

# Accept either GID or PGID:
export PGID="${PGID:-${DEFAULT_GID}}"

# Accept UMASK:
umask "${UMASK:-0022}"

if [ -x "$PS_RUN_AT_STARTUP" ]; then
  "$PS_RUN_AT_STARTUP"
fi

maybe_chown() {
  if [ -d "$0" ] && [ "$(stat -c '%u' "$0")" != "$PUID" ]; then
    chown --silent --recursive node:node "$0"
  fi

}

# Let the user shell into the container:
if [ "$*" = "sh" ] || [ "$*" = "dash" ] || [ "$*" = "bash" ]; then
  exec "$*"
elif [ "$PUID" = "0" ] || [ "$(id --real --user)" != "0" ]; then
  # They either want to run as root, or started docker with --user, so we
  # shouldn't do any usermod/groupmod/su shenanigans.

  # We `exec` to replace the current shell so nothing is between tini and node:
  exec /usr/local/bin/node /ps/app/photostructure "$@"
else
  # Change the node user and group to match PUID/PGID.

  # (we don't care about "usermod: no changes"):
  groupmod --non-unique --gid "$PGID" node
  usermod --non-unique --uid "$PUID" --gid "$PGID" node >/dev/null

  if [ -z "$PS_NO_PUID_CHOWN" ]; then
    # Always make sure the settings, opened-by, and models directories are
    # read/writable by node.
    for dir in /ps/library/.photostructure/settings.toml \
      /ps/library/.photostructure/opened-by \
      /ps/library/.photostructure/models \
      /ps/library/.photostructure/previews \
      /ps/library/.photostructure/sync-reports \
      /ps/config \
      /ps/logs \
      /ps/default; do
      maybe_chown "$dir"
    done

    # Special handling so we don't do something terrible if someone bind-mounts /tmp to /ps/tmp
    if [ -d /ps/tmp ]; then
      mkdir -p "/ps/tmp/.cache-$PUID"
      maybe_chown "/ps/tmp/.cache-$PUID"
    fi
  fi

  # Start photostructure as the user "node" instead of root.

  # We `exec` to replace the current shell so nothing is between tini and
  # node.

  # BTW: Alpine's busybox-powered `su` doesn't support --preserve-environment
  # (-p), or --command (-c).
  exec su -p node -c "/usr/local/bin/node /ps/app/photostructure $*"
fi
