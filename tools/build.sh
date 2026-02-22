#!/bin/bash -ex

# This builds static binaries using the currently-oldest-supported version of
# Ubuntu and copies them into place

# To get buildx to support arm64: `apt install qemu-user-static`

# To see what platforms buildx knows about: `docker buildx ls`

# FWIW Raspbian on Raspberry Pi 3 and later support arm64 instruction sets.

export DOCKER_BUILDKIT=1
for platform in amd64 arm64; do
  mkdir -p dist/$platform
  # Run both docker builds in parallel:
  # Use --output type=local to extract files directly to the host filesystem
  docker build --platform linux/$platform --file Dockerfile --output type=local,dest=./dist/$platform . &
done

# Wait for both builds to finish:
wait

# Move the binaries into place. Note that node's `os.arch()` returns "x64" for
# amd64, so we do the translation here.
mv dist/amd64/* linux-x64/
mv dist/arm64/* linux-arm64/

# and we're done!

rm -rf dist
