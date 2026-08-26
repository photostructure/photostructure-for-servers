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
# Account renumbering is the exception: if it fails, launching with stale IDs
# would create files the operator may not be able to read or modify.

# The image renames the base image's `node` user and group to `photostructure`
# at build time. If PUID/PGID is set, this script renumbers that dedicated
# account instead of creating a second passwd/group entry for the same IDs.
# The application tree and Node installation are root-owned and
# world-readable/executable, so changing the account IDs does not orphan files
# that the runtime process needs.

# As of v2023.8:
# - the photostructure code and resources were moved from /ps/... to
#   /opt/photostructure to avoid being squashed by a typo-ed /ps user bind
#   mounts.

# As of v2024.7:
# - $PUID and $PGID are respected when spawning a shell into a new container.
# - $PS_LIBRARY_DIR and $PS_CONFIG_DIR overrides are respected for defaulting
#   PUID and PGID.

# This entrypoint targets the Debian docker image and runs under dash
# (which is why the shebang is `#!/bin/sh` instead of `#!/bin/bash`).

# --- script starts here ---

# Propagate ctrl-c while we're still in this script:
trap 'exit 130' INT

# (Prior versions set PATH, PS_IS_DOCKER, and NODE_ENV here, but that's now
# handled as ENV settings in the Dockerfile)

# Resolve settings before privileged filesystem work. Capture first so a Node
# failure cannot leave a partially initialized shell environment.
_docker_env=$(node /opt/photostructure/bin/docker-env.js) || exit $?
eval "$_docker_env"
unset _docker_env

# Accept an explicit UMASK exactly, or use the documented 0022 default.
umask "${UMASK:-0022}"

# Copy root-only DMI identifiers before dropping privileges to $PUID. Clear old
# copies because /run survives container restarts.
stage_dmi() {
  for _f in product_uuid board_serial product_serial chassis_serial; do
    _dest="/run/photostructure/dmi/$_f"
    if [ -r "/sys/class/dmi/id/$_f" ]; then
      # Ignore UMASK so $PUID can traverse both new directories.
      (umask 0022 && mkdir -p /run/photostructure/dmi) || return 0
      install -m 0444 "/sys/class/dmi/id/$_f" "$_dest" || rm -f "$_dest"
    else
      rm -f "$_dest"
    fi
  done
  unset _dest _f
}

stage_dmi

# Renumber the image's dedicated account when running as root with a nonzero
# PUID:

if [ "$(id --real --user)" = "0" ] && [ "$PUID" != "0" ]; then

  # --non-unique preserves the PUID/PGID contract when either target ID is
  # already present in a derived image or injected passwd/group database.
  if [ "$(id --group photostructure)" != "$PGID" ]; then
    groupmod --non-unique --gid "$PGID" photostructure || {
      _status=$?
      printf 'Cannot set the photostructure group ID to %s\n' "$PGID" >&2
      exit "$_status"
    }
  fi
  if [ "$(id --user photostructure)" != "$PUID" ] ||
    [ "$(id --group photostructure)" != "$PGID" ]; then
    usermod --non-unique --uid "$PUID" --gid "$PGID" photostructure || {
      _status=$?
      printf 'Cannot set the photostructure user ID to %s\n' "$PUID" >&2
      exit "$_status"
    }
  fi
  # usermod updates existing home files to the new UID. Do not force their GID:
  # /home may be hidden by an operator mount, and the runtime does not use this
  # account home.

  # Note "$1" -- inside a shell function, $0 is still the script's own name.

  maybe_chown_dir() {
    # PS_CONFIG_DIR and PS_LIBRARY_DIR are user-influenced and reach this
    # recursive chown. chown defaults to --no-preserve-root, so a stray "/" --
    # or anything resolving there, like "/ps/.." -- would rewrite ownership of
    # the entire container, mounted volumes included. Canonicalize, then refuse
    # the root outright; --preserve-root is the second line of defense.
    # Check before canonicalizing as well as after: `readlink -f ""` reports the
    # current directory, so an empty value would otherwise chown $PWD.
    case $1 in
    "" | /) return 0 ;;
    esac
    _chown_target=$(readlink -f "$1" 2>/dev/null || printf '%s' "$1")
    case $_chown_target in
    "" | /) return 0 ;;
    esac
    if [ -d "$_chown_target" ] &&
      [ "$(stat -c '%u' "$_chown_target")" != "$PUID" ]; then
      chown --silent --recursive --preserve-root \
        photostructure:photostructure "$_chown_target"
    fi
  }

  # A brand new bind mount arrives owned by root, and the loop below cannot
  # help: its only library target is "$PS_LIBRARY_DIR/.photostructure", which
  # does not exist yet, and maybe_chown_dir() skips what isn't there. The
  # dropped-privileges process then can't create it, so first-run setup
  # dead-ends -- and licensing quietly loses li:, si:, and vl: at once, leaving
  # the install minting licenses anchored only on commodity hardware.
  #
  # Fix the root whenever it is mis-owned and the dropped user cannot already
  # write to it: a first run against a fresh mount, a library migrated as
  # root, or an install that ran as root before adopting PUID. Never
  # recursively -- the root's contents may be terabytes of photos whose
  # ownership is the operator's business, and a mis-typed PS_LIBRARY_DIR must
  # stay a one-inode mistake, not a share-wide rewrite. The loop below
  # recursively repairs .photostructure, which is PhotoStructure's own data.

  maybe_chown_library_root() {
    # Guard before canonicalizing as well as after: `readlink -f ""` reports the
    # current directory. See maybe_chown_dir() above for the same two-step.
    case $1 in
    "" | /) return 0 ;;
    esac
    _root=$(readlink -f "$1" 2>/dev/null || printf '%s' "$1")
    case $_root in
    "" | /) return 0 ;;
    esac
    [ -d "$_root" ] || return 0
    [ "$(stat -c '%u' "$_root")" != "$PUID" ] || return 0
    # A root that the dropped user can already write to (say, a group- or
    # world-writable NAS export) needs nothing -- don't mutate what works.
    # setpriv clears capabilities on the uid change, so `test` sees exactly
    # what the child will.
    # shellcheck disable=SC2016 # $1 expands in the child /bin/sh, not here.
    if setpriv --reuid=photostructure --regid=photostructure --init-groups \
      /bin/sh -c '[ -w "$1" ] && [ -x "$1" ]' sh "$_root" 2>/dev/null; then
      return 0
    fi
    chown --silent photostructure:photostructure "$_root"
  }

  # CHOWN_CACHE_DIR is the operator's explicit cache location (environment or
  # settings.toml), resolved by docker-env.js and deliberately not exported:
  # the app must keep reading it through its own settings precedence. Empty
  # when unset, so maybe_chown_dir() skips it.

  if [ -z "$PS_NO_PUID_CHOWN" ]; then
    # Refuse a cache target that contains the library: the recursive chown
    # below would rewrite ownership across the photo collection. docker-env
    # already refuses the un-canonicalized spelling; canonicalizing here
    # covers symlinked paths too.
    if [ -n "$CHOWN_CACHE_DIR" ]; then
      _canon_cache=$(readlink -f "$CHOWN_CACHE_DIR" 2>/dev/null ||
        printf '%s' "$CHOWN_CACHE_DIR")
      _canon_library=$(readlink -f "$PS_LIBRARY_DIR" 2>/dev/null ||
        printf '%s' "$PS_LIBRARY_DIR")
      case $_canon_library in
      "$_canon_cache" | "$_canon_cache"/*) CHOWN_CACHE_DIR="" ;;
      esac
    fi

    # The cache target may not exist yet -- XDG_CACHE_HOME resolves to an
    # app-owned child of a mount the dropped user cannot write. Create just
    # the leaf, never a chain, so the loop below can chown it.
    if [ -n "$CHOWN_CACHE_DIR" ] && [ ! -e "$CHOWN_CACHE_DIR" ] &&
      [ -d "$(dirname -- "$CHOWN_CACHE_DIR")" ]; then
      mkdir -- "$CHOWN_CACHE_DIR" 2>/dev/null || true
    fi

    maybe_chown_library_root "$PS_LIBRARY_DIR"
    for dir in \
      "$PS_LIBRARY_DIR/.photostructure" \
      "$PS_CONFIG_DIR" \
      "$CHOWN_CACHE_DIR" \
      /ps/tmp \
      /ps/cache \
      /ps/logs; do
      maybe_chown_dir "$dir"
    done
  fi

fi

# What are we running? Unless the user is shelling into the container -- in
# which case "$@" already starts with the shell they named -- it's
# PhotoStructure itself.

# The pathname doesn't need to be absolute: $PATH should be set up reasonably
# already. This is simply to be explicit.

case $1 in
sh | dash | bash) ;;
*) set -- /opt/photostructure/bin/photostructure.js "$@" ;;
esac

if [ -z "$DROP_PRIVILEGES" ]; then

  # `exec` to replace the current shell, so nothing is between tini and node.

  exec "$@"

fi

# Dropping privileges goes through setpriv (util-linux, already in the base
# image): a pure execve-based drop, the model gosu and the official Postgres
# and Redis entrypoints use. argv passes through verbatim -- no re-parsing --
# and nothing supervises the app, so tini's SIGTERM reaches node directly and
# the app keeps the container's whole grace period.
#
# This replaced `su -p -c` (2026-08). su takes the command as one *string*
# its shell re-parses (argv had to be re-quoted into it), SIGKILLs its child
# 2 seconds after forwarding SIGTERM ("Session terminated, killing shell...")
# -- against a syncExitTimeoutMs defaulting to 2 minutes because shutdown may
# need to copy the library database back to a remote filesystem -- and resets
# resource limits: after a probe set RLIMIT_NOFILE to 12345, su reset it to
# 1024 on this base image. PAM also made the default umask depend on group-name
# resolution: 0002 for a new user-private group, but 0022 for the common
# PUID=PGID=1000 collision with the image's former `node` group. Do not
# recreate that inconsistency: the documented 0022 default set above applies
# to both paths, and an explicit UMASK (including 0002) passes through exactly.

exec setpriv \
  --reuid=photostructure \
  --regid=photostructure \
  --init-groups \
  --inh-caps=-all \
  "$@"
