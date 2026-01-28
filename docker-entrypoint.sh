#!/bin/sh

# Copyright © 2023, PhotoStructure Inc.

# BY RUNNING THIS SOFTWARE YOU AGREE TO ALL THE TERMS OF THIS LICENSE:
# <https://photostructure.com/eula>

# See <https://photostructure.com/server> for instructions,
# <https://forum.photostructure.com/> for support, and
# <https://photostructure.com/go/discord> to hop into our Discord (we're
# probably online!)

## CHANGELOG / NOTES

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
# missing, we default to root for both PUID and PGID.

# See <https://photostructure.com/go/puid> for more details.

# Prior to v2.1, this script would exit with a non-zero status if anything was
# amiss. It turns out that lots of users aren't running this image from a
# command line, and so this script really tries to get PhotoStructure spun up,
# and relies on error reporting from the splash screen. This should make it
# easier for all users to debug their installation setup.

# Prior to v2.1, if PUID/PGID was set, we'd _reuse_ the existing `node` user and
# group, and reassign the uid/gid. Unfortunately, the LTS node image (as of
# 2023) installs some files in /opt/yarn which are owned by node:node, so
# reassigning the userid can be problematic. We now create a new
# `photostructure` user instead.

# As of v2023.8:
# - the photostructure code and resources were moved from /ps/... to
#   /opt/photostructure to avoid being squashed by a typoed /ps user bind
#   mounts.

# As of v2024.7:
# - $PUID and $PGID are respected when spawning a shell into a new container.
# - $PS_LIBRARY_DIR and $PS_CONFIG_DIR overrides are respected for defaulting
#   PUID and PGID.

# Note that this same entrypoint is used for the Debian and Alpine docker
# images, so this needs to run properly under both busybox (for Alpine), and
# dash (for debian) (which is why the shebang is `#!/bin/sh` instead of
# `#!/bin/bash`).

# --- script starts here ---

# Propagate ctrl-c while we're still in this script:
trap 'exit 130' INT

# (Prior versions set PATH, PS_IS_DOCKER, and NODE_ENV here, but that's now
# handled as ENV settings in the Dockerfile)

# PhotoStructure settings are split into 2 different configurations--one
# "system" setting file that (mostly) tells PhotoStructure where the library
# is, and one "library" settings file where everything else is configured.

# That said, these `stats` calls are just to get a reasonable default user id
# and group id, in case PUID or PGID aren't set.

# We prefer /ps/config over /ps/library/... as /ps/config may be specific to
# this machine, whereas the library directory could be shared with other
# machines with different UID/GIDs.

PS_LIBRARY_DIR="${PS_LIBRARY_DIR:-${PS_LIBRARY:-/ps/library}}"

if [ -z "$PS_CONFIG_DIR" ]; then
  if [ -d "/ps/config" ]; then
    PS_CONFIG_DIR="/ps/config"
  else
    PS_CONFIG_DIR="$PS_LIBRARY_DIR/.photostructure/docker-config"
  fi
fi

DEFAULT_UID=$(
  stat -c %u "$PS_CONFIG_DIR/settings.toml" 2>/dev/null ||
    stat -c %u "$PS_LIBRARY_DIR/.photostructure/settings.toml" 2>/dev/null ||
    stat -c %u "$PS_LIBRARY_DIR/.photostructure" 2>/dev/null ||
    stat -c %u "$PS_CONFIG_DIR" 2>/dev/null ||
    stat -c %u "$PS_LIBRARY_DIR" 2>/dev/null ||
    echo 0
)

DEFAULT_GID=$(
  stat -c %g "$PS_CONFIG_DIR/settings.toml" 2>/dev/null ||
    stat -c %g "$PS_LIBRARY_DIR/.photostructure/settings.toml" 2>/dev/null ||
    stat -c %g "$PS_LIBRARY_DIR/.photostructure" 2>/dev/null ||
    stat -c %g "$PS_CONFIG_DIR" 2>/dev/null ||
    stat -c %g "$PS_LIBRARY_DIR" 2>/dev/null ||
    echo 0
)

# Accept either $PUID or $puid:
export PUID="${PUID:-${puid:-${DEFAULT_UID}}}"

# Accept either $PGID or $pgid:
export PGID="${PGID:-${pgid:-${DEFAULT_GID}}}"

# Accept UMASK, or default to 0022:
umask "${UMASK:-0022}"

# This handles the run-as-root or run-as-new-user-using-su call to `exec`:

EXEC="exec"

# Only try to make a new user if we're running as root, and PUID is set to
# something not-zero:

if [ "$(id --real --user)" = "0" ] && [ "$PUID" != "0" ]; then

  # We want to run as userid $PUID and groupid $PGID. Unfortunately, those IDs
  # may already be in use by the container (probably by the "node" user and
  # group, both which use 1000), so we need to use `groupadd` and `useradd`
  # (rather than addgroup and adduser), which have the `--non-unique` option.

  # Create a new "photostructure" user and group to match PUID/PGID:

  groupadd --non-unique --gid "$PGID" photostructure
  useradd --non-unique --uid "$PUID" --gid "$PGID" photostructure

  # Ensure the new "photostructure" user is in the "node" group so it can run
  # node and everything in /opt/photostructure:

  adduser photostructure node

  maybe_chown_dir() {
    if [ -d "$0" ] && [ "$(stat -c '%u' "$0")" != "$PUID" ]; then
      chown --silent --recursive photostructure:photostructure "$0"
    fi
  }

  if [ -z "$PS_NO_PUID_CHOWN" ]; then
    for dir in \
      /ps/library \
      /ps/library/.photostructure \
      /ps/tmp \
      /ps/cache \
      /ps/config \
      /ps/logs; do
      maybe_chown_dir "$dir"
    done
  fi

  # Alpine's busybox-powered `su` doesn't support the long-arg variants of
  # --preserve-environment (alias for `-p`), or --command (alias for `-c`), so
  # we need to use the short args:

  EXEC="exec su -p photostructure -c"
fi

if [ "$1" = "sh" ] || [ "$1" = "dash" ] || [ "$1" = "bash" ]; then

  # Let the user shell into the container:

  $EXEC "$@"

else

  # - we `exec` to replace the current shell so nothing is between tini and
  #   node.

  # - these don't need to be full pathnames to the binaries: $PATH should be
  #   set up reasonably already. This simply to be explicit.

  $EXEC /opt/photostructure/bin/photostructure.js "$@"

fi
