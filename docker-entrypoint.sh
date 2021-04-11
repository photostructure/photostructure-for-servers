#!/bin/sh

# Tell PhotoStructure we're running under docker:
export PS_IS_DOCKER="1"

# Node is installed in /usr/local/bin:
export PATH="${PATH}:/usr/local/bin"

# Are we root?
if [ "$(id -ru)" = "0" ]; then
  # Accept either UID or PUID:
  UID=${UID:-${PUID:-1000}}
  # Accept either GID or PGID:
  GID=${GID:-${PGID:-1000}}

  # Change the phstr user and group to match UID/GID.
  # (we don't care about "usermod: no changes"):
  usermod --non-unique --uid "$UID" phstr | grep -v "usermod: no changes"
  groupmod --non-unique --gid "$GID" phstr

  # - `exec tini` to prevent zombies
  # - Start photostructure as user phstr instead of root:
  su --preserve-environment phstr -c "/usr/local/bin/node /ps/app/photostructure $*"
else
  # They started docker with --user (and hopefully are using userns!), so we
  # shouldn't do any usermod/groupmod/su shenanigans:
  /usr/local/bin/node /ps/app/photostructure "$@"
fi
