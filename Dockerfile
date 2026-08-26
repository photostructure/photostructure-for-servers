# syntax=docker/dockerfile:1

# Howdy! Need help? See
# <https://photostructure.com/server/photostructure-for-docker/>

# https://github.com/photostructure/base-tools/pkgs/container/base-tools-debian
FROM photostructure/base-tools-debian:sha-fdafa0d AS builder

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /opt/photostructure

COPY package.json package-lock.json ./

# base-tools-debian will install build-essential and libraries that native
# node packages require to be compiled. We don't need the compilation
# toolchain, though--just the compiled native libraries, so once this is done,
# we switch to the smaller base image.
RUN npm ci --omit=dev

# This must match the major version from
# https://github.com/photostructure/base-tools-debian/blob/main/Dockerfile
# We use node:24 (not node:24.x) because native modules use N-API which is
# ABI-stable across Node versions. This allows automatic security patches.
FROM node:24-trixie-slim

# External tool runtime dependencies:
# libjpeg-turbo-progs includes `jpegtran` for lossless rotation and JPEG file validation
# libreadline8 is for the static sqlite3 CLI tool
# passwd provides `usermod` and `groupmod` (used below and by the entrypoint)
# perl is required for exiftool
# procps provides a working `ps -o lstart`
# wget is used by the health check
# tini is an `init` that supports proper zombie and signal handling

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  ca-certificates \
  libjpeg-turbo-progs \
  libreadline8t64 \
  locales-all \
  passwd \
  perl \
  procps \
  ripgrep \
  tini \
  tzdata \
  wget \
  && rm -rf /var/lib/apt/lists/* \
  && npm install --force --location=global npm \
  && groupmod --new-name photostructure node \
  && usermod --login photostructure \
  --home /home/photostructure --move-home node \
  && touch /.running-in-container

# No `sudo`, no sudoers drop-in: optional external tools are installed on demand,
# after the user opts in, as the unprivileged runtime user, into a per-user
# prefix under the config dir. Adding sudo back won't help: setuid is inert under
# `--security-opt no-new-privileges=true`, which TrueNAS SCALE sets on every app.

# Sets the default path to be inside /opt/photostructure when running `docker exec -it`:
WORKDIR /opt/photostructure

COPY --chown=root:root . ./

# Overwrite source with builder results (/opt/photostructure/tools):
COPY --from=builder --chown=root:root /opt/photostructure ./

# ---

# The node docker image sets NODE_VERSION and YARN_VERSION environment
# variables, which has caused concern and confusion with some users.

# Unfortunately, Docker doesn't support _deleting_ prior-set ENV values--you
# can only set them to "", which is still visible to the container manager and
# we're just replacing a _correct_ value with an _incorrect_ value, so that's
# certainly not _better_.

# So, we're just going to decide to be OK with NODE_VERSION and YARN_VERSION.

# Note that in prior versions of PhotoStructure, we used to set
# PS_IS_DOCKER=1. PhotoStructure still will honor the value of that
# environment variable if it is set to a truthy value, but if it is not set,
# PhotoStructure will look for the presence of a /.running-in-container file
# (which was created in the RUN command above).

# These PATH elements are not required by PhotoStructure--this is only here to
# make the command-line tooling (like `photostructure` and `sqlite3`)
# available when people shell into their containers. 

# Run `photostructure --help` or visit https://photostructure.com/tools/ for
# details about these tools.
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/photostructure:/opt/photostructure/tools"

# Document the container port. Publishing is controlled by docker run
# --publish or compose.yaml ports. Bind to 127.0.0.1 on the host if you want
# host-only access.
EXPOSE 1787

# Healthcheck: ping the web server to verify it's responding.
# - Uses PS_HTTP_PORT if set, otherwise defaults to 1787
# - start-period: PhotoStructure can take time to initialize on first run
# - interval/timeout: balance between responsiveness and resource usage
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget --quiet --output-document - "http://localhost:${PS_HTTP_PORT:-1787}/ping"

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact

# docker-entrypoint.sh renumbers the dedicated "photostructure" account before
# dropping privileges, so custom PUID/PGID values do not create a second user.
ENTRYPOINT [ "/usr/bin/tini", "--", "/opt/photostructure/docker-entrypoint.sh" ]
