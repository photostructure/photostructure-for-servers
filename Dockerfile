# syntax=docker/dockerfile:1

# Howdy! Need help? See
# <https://photostructure.com/server/photostructure-for-docker/>

FROM photostructure/base-tools as builder

# https://docs.docker.com/develop/develop-images/multistage-build/

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /opt/photostructure

COPY package.json yarn.lock ./

# base-tools will install build-essential and libraries that native node
# packages require to be compiled.

RUN yarn install --frozen-lockfile --production --no-cache

# This must match the base image from base-tools:
FROM node:20-alpine3.18

# procps provides a working `ps -o lstart`
# coreutils provides a working `df -kPl`
# glib is for gio (for mountpoint monitoring)
# util-linux (which should be there already) provides `renice` and `lsblk`
# musl-locales provides `locale`
# orc is for sharp SIMD operations
# perl is required for exiftool.
# libheif-tools provides "heif-convert"
# libraw-tools provides "dcraw_emu" and "raw-identify"
# shadow provides usermod

# https://pkgs.alpinelinux.org/contents

RUN apk update \
  && apk upgrade \
  && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/latest-stable/community musl-locales \
  && apk add --no-cache \
  bash \
  coreutils \
  ffmpeg \
  glib \
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
  && npm install --force --location=global npm yarn
#    ^ fetch any recent updates to npm or yarn 

# Sets the default path to be inside /opt/photostructure when running `docker exec -it`:
WORKDIR /opt/photostructure

COPY --chown=node:node . ./

# Copy in builder results (/opt/photostructure/tools, /opt/photostructure/node_modules):
COPY --from=builder --chown=node:node /opt/photostructure ./

# Your library is exposed by default to <http://localhost:1787>
# This can be changed by setting the PS_HTTP_PORT environment variable.
EXPOSE 1787

# We're not installing curl, but busybox has a wget workalike:
HEALTHCHECK CMD wget --quiet --output-document - http://localhost:1787/ping

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact

# docker-entrypoint.sh handles custom $PUID/$PGID
ENTRYPOINT [ "/sbin/tini", "--", "/opt/photostructure/docker-entrypoint.sh" ]
