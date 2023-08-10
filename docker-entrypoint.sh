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

# Prior to v2.1, if PUID/PGID was set, we'd _reuse_ the existing `node` user
# and group, and reassign the uid/gid. Unfortunately, the LTS node image (as
# of 2023) installs files in /opt/yarn which are owned by node:node, so
# reassigning the userid can be problematic. We now create a new
# `photostructure` user instead.

# As of v2023.6, the photostructure code and resources were moved from /ps/...
# to /opt/photostructure to avoid being squashed by a typoed /ps user bind
# mounts.

# Note that this same entrypoint is used for the Debian and Alpine docker
# images, so this needs to run under busybox (for Alpine), and dash (for
# debian).

# --- script starts here ---

# Propagate ctrl-c while we're still in this script:
trap 'exit 130' INT

# `node` is installed in /usr/local/bin:
export PATH="/opt/photostructure:/opt/photostructure/tools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# PhotoStructure looks for this environment variable to be "1" or "true" to
# know it's running in Docker. This had been set in the Dockerfile, but that
# confused people.
export PS_IS_DOCKER=1

export NODE_ENV=production

# We "trust" the /ps/config ownership a bit more than the /ps/library
# directory because /ps/config is specific to this machine, whereas the
# library directory could be shared with other machines with different
# UID/GIDs.

DEFAULT_UID=$(
  stat -c %u /ps/config/settings.toml 2>/dev/null ||
    stat -c %u /ps/library/.photostructure/settings.toml 2>/dev/null ||
    stat -c %u /ps/library/.photostructure 2>/dev/null ||
    stat -c %u /ps/config 2>/dev/null ||
    stat -c %u /ps/library 2>/dev/null ||
    echo 0
)

DEFAULT_GID=$(
  stat -c %g /ps/config/settings.toml 2>/dev/null ||
    stat -c %g /ps/library/.photostructure/settings.toml 2>/dev/null ||
    stat -c %g /ps/library/.photostructure 2>/dev/null ||
    stat -c %g /ps/config 2>/dev/null ||
    stat -c %g /ps/library 2>/dev/null ||
    echo 0
)

# Accept either $PUID or $puid:
export PUID="${PUID:-${puid:-${DEFAULT_UID}}}"

# Accept either $PGID or $pgid:
export PGID="${PGID:-${pgid:-${DEFAULT_GID}}}"

# Accept UMASK:
umask "${UMASK:-0022}"

if [ -x "$PS_RUN_AT_STARTUP" ]; then
  "$PS_RUN_AT_STARTUP"
fi

if [ "$1" = "sh" ] || [ "$1" = "dash" ] || [ "$1" = "bash" ]; then
  # Let the user shell into the container:
  exec "$@"
elif [ "$PUID" = "0" ] || [ "$(id --real --user)" != "0" ]; then

  # They either want to run as root, or started docker with --user, so we
  # shouldn't do any usermod/groupmod/su shenanigans.

  # Implementation notes:

  # - we `exec` to replace the current shell so nothing is between tini and
  #   node.

  # - these don't need to be full pathnames to the binaries: $PATH should be
  #   set up reasonably already. This simply to be explicit.

  # - although /opt/photostructure/photostructure has a valid shebang line, we
  #   can avoid spawning an extra `sh` by exec'ing node directly and make
  #   launching a bit faster.

  exec /usr/local/bin/node /opt/photostructure/photostructure "$@"
else

  # We want to run as userid $PUID and groupid $PGID. Unfortunately, those IDs
  # may already be in use by the container (probably by the "node" user and
  # group, both which use 1000), so we need to use `groupadd` and `useradd`,
  # which have the (very!) handy `--non-unique` option.

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
    for dir in /ps/library/.photostructure \
      /ps/tmp \
      /ps/cache \
      /ps/config \
      /ps/logs; do
      maybe_chown_dir "$dir"
    done
  fi

  # Start photostructure as the user "phstr" instead of root.

  # Implementation notes:

  # - we `exec` to replace the current shell so nothing is between tini and
  #   node.

  # - these don't need to be full pathnames to the binaries: $PATH should be
  #   set up reasonably already. This simply to be explicit.

  # - although /opt/photostructure/photostructure has a valid shebang line, we
  #   can avoid spawning an extra `sh` by exec'ing node directly and make
  #   launching a bit faster.

  # - Alpine's busybox-powered `su` doesn't support the long-arg variants of
  #   --preserve-environment (alias for `-p`), or --command (alias for `-c`).
  exec su -p photostructure -c "/usr/local/bin/node /opt/photostructure/photostructure $*"
fi
