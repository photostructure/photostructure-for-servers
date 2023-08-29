# syntax=docker/dockerfile:1

# Howdy! Need help? See
# <https://photostructure.com/server/photostructure-for-docker/>

FROM photostructure/base-tools-debian as builder

# https://docs.docker.com/develop/develop-images/multistage-build/

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /opt/photostructure

COPY package.json yarn.lock ./

# base-tools-debian will install build-essential and libraries that native
# node packages require to be compiled.

RUN yarn install --frozen-lockfile --production --no-cache

# This must match the base image from base-tools-debian:
FROM node:20-bookworm-slim

# ffmpeg is used for video frame extraction and transcoding
# libheif-examples provides "heif-convert"
# libjpeg-turbo-progs includes `jpegtran` for lossless rotation and JPEG file validation
# libjpeg62-turbo-dev is used by VIPS for JPEG handling
# liblcms2-dev supports color management
# liborc-0.4-dev is for sharp SIMD operations
# passwd provides `usermod` and `groupmod` (used by docker-entrypoint.sh)
# perl is required for exiftool.
# procps provides a working `ps -o lstart`
# wget is used by the health check.
# tini is an `init` that supports proper zombie and signal handling

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  ffmpeg \
  libheif-examples \
  libjpeg-turbo-progs \
  libjpeg62-turbo \
  liblcms2-2 \
  liborc-0.4-0 \
  locales-all \
  passwd \
  perl \
  procps \
  tini \
  tzdata \
  wget \
  && rm -rf /var/lib/apt/lists/* \
  && npm install --force --location=global npm yarn

# Sets the default path to be inside /opt/photostructure when running `docker exec -it`:
WORKDIR /opt/photostructure

COPY --chown=node:node . ./

# Overwrite source with builder results (/opt/photostructure/tools/bin):
COPY --from=builder --chown=node:node /opt/photostructure ./

# Your library is exposed by default to <http://localhost:1787>
# This can be changed by setting the PS_HTTP_PORT environment variable.
EXPOSE 1787

# We're not installing curl, but busybox has a wget workalike:
HEALTHCHECK CMD wget --quiet --output-document - http://localhost:1787/ping

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact

# docker-entrypoint.sh handles dropping privileges down to the "node" user in order
# to support custom PUID/PGID
ENTRYPOINT [ "/usr/bin/tini", "--", "/opt/photostructure/docker-entrypoint.sh" ]
