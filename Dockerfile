# https://docs.docker.com/develop/develop-images/multistage-build/

FROM node:14-alpine as builder

# Build requirements for native node libraries:
# sharp needs lcms2 and libjpeg

RUN apk update ; apk upgrade ; apk add --no-cache \
  build-base \
  coreutils \
  lcms2-dev \
  libjpeg-turbo-dev \
  python3-dev

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /ps/app

COPY package.json ./

RUN yarn install

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
# libheif-tools provides "heif-convert"
# libraw-tools provides "dcraw_emu" and "raw-identify"

# https://pkgs.alpinelinux.org/contents

RUN apk update ; apk upgrade ;\
  apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.12/community musl-locales ;\
  apk add --no-cache \
  coreutils \
  ffmpeg \
  glib \
  libheif-tools \
  libjpeg-turbo-utils \
  libraw-tools \
  perl \
  procps \
  sqlite \
  tini \
  util-linux

# Sets the default path to be inside app when running `docker exec -it`
WORKDIR /ps/app

COPY  . ./
COPY --from=builder /ps/app ./

# Your library is exposed by default to <http://localhost:1787>
# This can be changed by setting the PS_HTTP_PORT environment variable.
EXPOSE 1787

# These environment variables tell PhotoStructure the volume mountpoints that
# are configured in docker-compose.yml. These ENV values should not be overridden.

# Tell PhotoStructure we're running under docker:
ENV PS_IS_DOCKER="1"

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

# Make it easier to run photostructure commands via `docker exec`:
ENV PATH="${PATH}:/ps/app:/ps/app/bin"

# These volume paths are configured in docker-compose.yml, using values set by
# photostructure.env. 
VOLUME [ "/ps/library", "/ps/logs", "/ps/tmp", "/ps/config" ]

# We're not installing curl, but busybox has a wget workalike:
HEALTHCHECK CMD wget --quiet --output-document - http://localhost:1787/ping

# Rather than hoping people use `docker run --init`, let's just do it for them by default:
ENTRYPOINT [ "/sbin/tini", "--" ]

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact
CMD [ "node", "/ps/app/photostructure" ]
