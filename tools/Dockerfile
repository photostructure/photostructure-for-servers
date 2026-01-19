# syntax=docker/dockerfile:1

# https://hub.docker.com/_/ubuntu We actually want this ancient version, as we
# want an old glibc to maximize compatibility with older systems:
FROM ubuntu:20.04 AS builder

# This should match the RUN command set from
# https://github.com/photostructure/base-tools-debian/blob/main/Dockerfile (except 

RUN apt-get update && \
  apt-get upgrade -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    autoconf \
    autogen \
    automake \
    build-essential \
    ca-certificates \
    curl \
    libjpeg-turbo8-dev \
    liblcms2-dev \
    liborc-0.4-dev \
    libreadline-dev \
    libtool \
    pkg-config \
    python3 \
    zlib1g-dev && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p /opt/photostructure/tools && \
  mkdir -p /tmp/libraw && \
  cd /tmp/libraw && \
  curl -L https://api.github.com/repos/LibRaw/LibRaw/tarball/09bea31181b43e97959ee5452d91e5bc66365f1f | tar -xz --strip 1 && \
  autoreconf -fiv && \
  ./configure --enable-static --disable-lcms --disable-openmp && \
  make -j $(nproc) && \
  /bin/bash ./libtool --tag=CXX --mode=link g++ -all-static -g -O2 -o bin/dcraw_emu samples/bin_dcraw_emu-dcraw_emu.o lib/libraw.la -ljpeg -lz -lm && \
  /bin/bash ./libtool --tag=CXX --mode=link g++ -all-static -g -O2 -o bin/raw-identify samples/bin_raw_identify-raw-identify.o lib/libraw.la -ljpeg -lz -lm && \
  cp -p bin/dcraw_emu bin/raw-identify /opt/photostructure/tools/ && \
  rm -rf /tmp/libraw && \
  mkdir -p /tmp/sqlite && \
  cd /tmp/sqlite && \
  curl https://sqlite.org/2025/sqlite-autoconf-3490100.tar.gz | tar -xz --strip 1 && \
  ./configure --enable-static --disable-shared --enable-readline && \
  make -j $(nproc) && \
  cp -p sqlite3 /opt/photostructure/tools/ && \
  rm -rf /tmp/sqlite && \
  strip /opt/photostructure/tools/*

# cmake and nasm is for libjpeg-turbo

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    cmake \
    nasm && \
  mkdir -p /tmp/jpegtran && \
  cd /tmp/jpegtran && \
  curl -L https://api.github.com/repos/libjpeg-turbo/libjpeg-turbo/tarball/adbb328159b5558e846690c49f9458deccbb0f43 | tar -xz --strip 1 && \
  cmake -G "Unix Makefiles" -DENABLE_SHARED=0 -DENABLE_STATIC=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="-static" -DCMAKE_EXE_LINKER_FLAGS="-static" && \
  make -j $(nproc) jpegtran-static && \
  cp -p jpegtran-static /opt/photostructure/tools/jpegtran && \
  rm -rf /tmp/jpegtran

FROM scratch AS export-stage
COPY --from=builder /opt/photostructure/tools .
