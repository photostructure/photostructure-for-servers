# syntax=docker/dockerfile:1

# Howdy, need help? See
# <https://photostructure.com/server/photostructure-for-docker/> and
# <https://forum.photostructure.com/>

# See <https://hub.docker.com/_/node/>

# See <https://github.com/photostructure/base-tools>
FROM photostructure/base-tools as builder

# https://docs.docker.com/develop/develop-images/multistage-build/

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /ps/app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile --production --no-cache

FROM node:lts-alpine

# Busybox's commands are a bit too bare-bones:
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

RUN apk update ; apk upgrade ;\
  apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/latest-stable/community musl-locales ;\
  apk add --no-cache \
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
  util-linux

# Sets the default path to be inside /ps/app when running `docker exec -it`:
WORKDIR /ps/app

COPY --chown=node:node . ./

# Overwrite source with builder results (node_modules and tools/bin):
COPY --from=builder --chown=node:node /ps/app ./

# Tell PhotoStructure that we're running in a docker container:
ENV PS_IS_DOCKER=true
ENV NODE_ENV=production

# Your library is exposed by default to <http://localhost:1787>
# This can be changed by setting the PS_HTTP_PORT environment variable.
EXPOSE 1787

# We're not installing curl, but busybox has a wget workalike:
HEALTHCHECK CMD wget --quiet --output-document - http://localhost:1787/ping

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact

# docker-entrypoint.sh handles dropping privileges down to the "node" user in order
# to support custom PUID/PGID
ENTRYPOINT [ "/sbin/tini", "--", "/ps/app/docker-entrypoint.sh" ]
