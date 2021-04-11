#!/bin/sh -ex

# Tell PhotoStructure we're running under docker:
export PS_IS_DOCKER="1"

# These environment variables tell PhotoStructure the volume mountpoints that
# are configured in docker-compose.yml. These ENV values should not be overridden.

# This is the path to the library in the docker image. You'll mount a directory
# from the host machine via VOLUME: 
export PS_LIBRARY_PATH="/ps/library"

# Log directory. No automatic deletion is done, and if PS_LOG_LEVEL is set to
# "info" or "debug", this can get large quickly.
export PS_LOG_DIR="/ps/logs"

# "Scratch" directory, that should be on fast local disk. The contents are
# automatically vacuumed periodically, but it can grow to ~ 1-2GB on a fast
# machine during initial import.
export PS_CACHE_DIR="/ps/tmp"

# System configuration directory. Stores system settings.
# See https://photostructure.com/settings/
export PS_CONFIG_DIR="/ps/config"

# Make it easier to run photostructure commands via `docker exec`:
export PATH="${PATH}:/ps/app:/ps/app/bin"

# Are we root?
if [ "$(id -ru)" = 0 ]; then
  # Accept either UID or PUID:
  UID=${UID:-${PUID:-1000}}
  # Accept either GID or PGID:
  GID=${GID:-${PGID:-1000}}

  # Change the phstr user and group to match UID/GID:
  usermod -o -u "$UID" phstr
  groupmod -o -g "$GID" phstr
  # We're only chowning the /ps/app to make sure we can read and execute the
  # app.

  # If we recursively chown'ed /ps, that'd include the /ps/library, which
  # could take ages and shouldn't be necessary.
  chown -R phstr:phstr /ps/app

  # `exec tini` to prevent zombies. Start photostructure as user phstr instead
  # of root:
  exec tini -- su phstr node /ps/app/photostructure
else
  # They started docker with --user (and hopefully are using userns!), so we
  # can't do any usermod/groupmod/su shenanigans:
  exec tini -- node /ps/app/photostructure
fi
