# syntax=docker/dockerfile:1

# Howdy! Need help? See
# <https://photostructure.com/server/photostructure-for-docker/>

# https://github.com/photostructure/base-tools/pkgs/container/base-tools-debian
FROM photostructure/base-tools-debian:sha-2f5c9bb as builder

# https://docs.docker.com/develop/develop-images/multistage-build/

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /opt/photostructure

COPY package.json yarn.lock ./

# base-tools-debian will install build-essential and libraries that native
# node packages require to be compiled. We don't need the compilation
# toolchain, though--just the compiled native libraries, so once this is done,
# we switch to the smaller base image.
RUN yarn install --frozen-lockfile --production --no-cache

# This must match the base image from
# https://github.com/photostructure/base-tools-debian/blob/main/Dockerfile
FROM node:20.11-bookworm-slim

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
  && npm install --force --location=global npm yarn \
  && touch /.running-in-container

# Sets the default path to be inside /opt/photostructure when running `docker exec -it`:
WORKDIR /opt/photostructure

COPY --chown=node:node . ./

# Overwrite source with builder results (/opt/photostructure/tools/bin):
COPY --from=builder --chown=node:node /opt/photostructure ./

# The node docker image sets NODE_VERSION and YARN_VERSION environment
# variables, which has causes concern and confusion with some users.

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

# Node.js and several third-party libraries look for this value to run in
# "production mode" (rather than "development mode").
ENV NODE_ENV="production"

# These PATH elements are not required by PhotoStructure--this is only here to
# make the command-line tooling (like `photostructure` and `sqlite3`)
# available when people shell into their containers. 

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
ENTRYPOINT [ "/usr/bin/tini", "--", "/opt/photostructure/docker-entrypoint.sh" ]
