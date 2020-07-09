# https://docs.docker.com/develop/develop-images/multistage-build/

FROM node:14-alpine as builder

# Build requirements for native node libraries:
RUN apk update ; apk upgrade ; apk add --no-cache \
  build-base \
  lcms2-dev \
  libjpeg-turbo-dev \
  python3-dev

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /ps/app

COPY . ./

RUN yarn install

# We need to build `dcraw` (as it isn't packaged by alpine)
WORKDIR /tmp

# busybox has `wget` but not `curl`.
RUN wget https://photostructure.com/src/dcraw.c ;\
  gcc -o dcraw -O4 dcraw.c -lm -DNODEPS ;\
  mkdir -p /ps/tools ;\
  cp dcraw /ps/tools/dcraw ;\
  chmod 755 /ps/tools/dcraw

#
# Stage 2: the final image:
#

FROM node:14-alpine

# Busybox's commands are a bit too bare-bones:
# procps provides a working `ps -o lstart`
# coreutils provides a working `df -kPl`
# glib is for gio (for mountpoint monitoring)
# util-linux (which should be there already) provides `renice` and `lsblk`
# musl-locales provides `locale`
# perl is required for exiftool.

# https://pkgs.alpinelinux.org/contents

RUN apk update ; apk upgrade ;\
  apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/v3.12/community musl-locales ;\
  apk add --no-cache \
  coreutils \
  ffmpeg \
  glib \
  libjpeg-turbo-utils \
  perl \
  procps \
  sqlite \
  util-linux

WORKDIR /ps

COPY --from=builder /ps ./

EXPOSE 1787

# These environment variables tell PhotoStructure the volume mountpoints that
# are configured in docker-compose.yml. These ENV values should not be overridden.

# Tell PhotoStructure we're running under docker:
ENV PS_DOCKER="1"

# This is the path to the library in the docker image. You'll mount a directory
# from the host machine via VOLUME: 
ENV PS_LIBRARY_PATH="/ps/library"

# Log directory. No automatic deletion is done, and if PS_LOG_LEVEL is set to
# "info" or "debug", this can get large quickly.
ENV PS_LOG_DIR="/ps/logs"

# "Scratch" directory, that should be on fast local disk. The contents are
# automatically vacuumed periodically, but it can grow to ~ 1-2GB on a fast
# machine during initial import.
ENV PS_CACHE_DIR="/ps/tmp"

# System configuration directory.
ENV PS_CONFIG_DIR="/ps/config"

# These volume paths are configured in docker-compose.yml, using values set by
# photostructure.env. 
VOLUME [ "/ps/library", "/ps/logs", "/ps/tmp", "/ps/config" ]

HEALTHCHECK CMD wget --quiet --output-document - http://localhost:1787/ping

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact
ENTRYPOINT [ "node", "/ps/app/photostructure" ]
