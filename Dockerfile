# syntax=docker/dockerfile:1

# Howdy! Need help? See
# <https://photostructure.com/server/photostructure-for-docker/>

# https://github.com/photostructure/base-tools/pkgs/container/base-tools
FROM photostructure/base-tools:sha-f31ad9c AS builder

# https://docs.docker.com/develop/develop-images/multistage-build/

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /opt/photostructure

COPY package.json package-lock.json ./

# base-tools will install build-essential and libraries that native node
# packages require to be compiled.
RUN npm ci --omit=dev

# This must match the major version from
# https://github.com/photostructure/base-tools/blob/main/Dockerfile
# We use node:24 (not node:24.x) because native modules use N-API which is
# ABI-stable across Node versions. This allows automatic security patches.
FROM node:24-alpine

# procps provides a working `ps -o lstart`
# coreutils provides a working `df -kPl`
# glib is for gio (for mountpoint monitoring)
# util-linux (which should be there already) provides `renice` and `lsblk`
# musl-locales provides `locale`
# orc is for sharp SIMD operations
# perl is required for exiftool.
# libheif-tools provides "heif-convert"
# libraw (dcraw_emu, raw-identify) is compiled in base-tools and copied to /opt/photostructure/tools
# shadow provides usermod

# https://pkgs.alpinelinux.org/contents

RUN apk update \
  && apk upgrade \
  && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/latest-stable/community musl-locales \
  && apk add --no-cache \
  bash \
  ca-certificates \
  coreutils \
  ffmpeg \
  glib \
  heif-thumbnailer \
  lcms2 \
  libheif-tools \
  libjpeg-turbo-utils \
  orc \
  pciutils \
  perl \
  procps \
  shadow \
  sqlite \
  tini \
  tzdata \
  util-linux \
  && npm install --force --location=global npm \
  && touch /.running-in-container

# Sets the default path to be inside /opt/photostructure when running `docker
# exec -it`:
WORKDIR /opt/photostructure

COPY --chown=node:node . ./

# Copy in builder results (/opt/photostructure/tools, /opt/photostructure/node_modules):
COPY --from=builder --chown=node:node /opt/photostructure ./

# The node docker image sets NODE_VERSION and YARN_VERSION environment
# variables, which has caused concern and confusion with some users.

# Unfortunately, Docker doesn't support _deleting_ prior-set ENV values--you can
# only set them to "", which is still visible to the container manager, and we're
# just replacing a _correct_ value with an _incorrect_ value, so that's
# certainly not _better_.

# So, we're just going to decide to be OK with NODE_VERSION and YARN_VERSION.

# Note that in prior versions of PhotoStructure, we used to set PS_IS_DOCKER=1.
# PhotoStructure still will honor the value of that environment variable if it
# is set to a truthy value, but if it is not set, PhotoStructure will look for
# the presence of a `/.running-in-container` file (which was created in the RUN
# command above).

# These PATH elements are not required by PhotoStructure--this is only here to
# make the command-line tooling (like `photostructure` and `sqlite3`) available
# when people shell into their containers. 

# Run `photostructure --help` or visit https://photostructure.com/tools/ for
# details about these tools.
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/photostructure:/opt/photostructure/tools/bin"

# Your library is exposed by default to <http://localhost:1787>
# This can be changed by setting the PS_HTTP_PORT environment variable.
EXPOSE 1787

# We're not installing curl, but busybox has a wget workalike:
HEALTHCHECK CMD wget --quiet --output-document - http://localhost:1787/ping

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact

# docker-entrypoint.sh handles dropping privileges down to the "node" user in order
# to support custom PUID/PGID
ENTRYPOINT [ "/sbin/tini", "--", "/opt/photostructure/docker-entrypoint.sh" ]
