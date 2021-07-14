# To get the latest libraw-tools and a recent sqlite we need alpine 3.13:
FROM node:16-alpine3.13 as builder

# https://docs.docker.com/develop/develop-images/multistage-build/

# Build requirements for native node libraries:
# libraw needs libtool, pkgconf, libjpeg-turbo-dev, and zlib-dev
# sharp needs lcms2 and libjpeg

RUN apk update ; apk upgrade ; apk add --no-cache \
  autoconf \
  bash \
  build-base \
  coreutils \
  lcms2-dev \
  libjpeg-turbo-dev \
  libtool \
  pkgconf \
  python3-dev \
  zlib-dev

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /ps/app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

# Build libraw (only necessary when the version with alpine is old)
# WORKDIR /tmp

# RUN wget https://www.libraw.org/data/LibRaw-0.20.2.tar.gz && \
#   echo "dc1b486c2003435733043e4e05273477326e51c3ea554c6864a4eafaff1004a6 LibRaw-0.20.2.tar.gz" | sha256sum --check && \
#   tar xvzf LibRaw-0.20.2.tar.gz && \
#   cd LibRaw-0.20.2 && \
#   ./configure --enable-static --disable-openmp && \
#   make -j24 && \
#   /bin/bash ./libtool --tag=CXX --mode=link g++ -all-static -g -O2 -o bin/dcraw_emu samples/bin_dcraw_emu-dcraw_emu.o lib/libraw.la -ljpeg -lz -lm && \
#   /bin/bash ./libtool --tag=CXX --mode=link g++ -all-static -g -O2 -o bin/raw-identify samples/bin_raw_identify-raw-identify.o lib/libraw.la -ljpeg -lz -lm && \
#   ldd bin/dcraw_emu && \
#   strip bin/dcraw_emu && \
#   strip bin/raw-identify && \
#   mkdir -p /ps/app/bin && \
#   cp dcraw_emu raw-identify /ps/app/bin && \
#   chmod 755 /ps/app/bin/*

FROM node:16-alpine3.13

# Busybox's commands are a bit too bare-bones:
# procps provides a working `ps -o lstart`
# coreutils provides a working `df -kPl`
# glib is for gio (for mountpoint monitoring)
# util-linux (which should be there already) provides `renice` and `lsblk`
# musl-locales provides `locale`
# perl is required for exiftool.
# libheif-tools provides "heif-convert"
# libraw-tools provides "dcraw_emu" and "raw-identify"
# shadow provides usermod

# https://pkgs.alpinelinux.org/contents

RUN apk update ; apk upgrade ;\
  apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.12/community musl-locales ;\
  apk add --no-cache \
  coreutils \
  ffmpeg \
  glib \
  lcms2 \
  libheif-tools \
  libjpeg-turbo-utils \
  libraw-tools \
  pciutils \
  perl \
  procps \
  shadow \
  sqlite \
  tini \
  util-linux

# Sets the default path to be inside app when running `docker exec -it`
WORKDIR /ps/app

COPY --chown=node:node . ./
COPY --from=builder --chown=node:node /ps/app ./

# Your library is exposed by default to <http://localhost:1787>
# This can be changed by setting the PS_HTTP_PORT environment variable.
EXPOSE 1787

# We're not installing curl, but busybox has a wget workalike:
HEALTHCHECK CMD wget --quiet --output-document - http://localhost:1787/ping

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact

# docker-entrypoint handles dropping privileges down to the "node" user:
ENTRYPOINT [ "/sbin/tini", "--", "/ps/app/docker-entrypoint.sh" ]
