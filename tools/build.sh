#!/bin/bash -ex

# Extract both Linux architectures from the pinned base-tools image, check
# SQLite against Ubuntu 24.04 NSS compat, then replace the bundled binaries.

# To get buildx to support arm64: `apt install qemu-user-static`

# To see what platforms buildx knows about: `docker buildx ls`

# FWIW Raspbian on Raspberry Pi 3 and later support arm64 instruction sets.

# Resolve this script's own directory so it works from any CWD.
TOOLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export DOCKER_BUILDKIT=1
for platform in amd64 arm64; do
  mkdir -p "$TOOLS_DIR/dist/$platform"
  # Run both docker builds in parallel:
  # Use --output type=local to extract files directly to the host filesystem
  docker build --platform linux/$platform --file "$TOOLS_DIR/Dockerfile" --output type=local,dest="$TOOLS_DIR/dist/$platform" "$TOOLS_DIR" &
done

# Wait for both builds to finish:
wait

# Catch static-libc/NSS incompatibilities before replacing bundled binaries.
bash "$TOOLS_DIR/test-sqlite-nss.sh" "$TOOLS_DIR/dist/amd64/sqlite3" linux/amd64
bash "$TOOLS_DIR/test-sqlite-nss.sh" "$TOOLS_DIR/dist/arm64/sqlite3" linux/arm64

# Move the binaries into place. Note that node's `os.arch()` returns "x64" for
# amd64, so we do the translation here.
mv "$TOOLS_DIR"/dist/amd64/* "$TOOLS_DIR/linux-x64/"
mv "$TOOLS_DIR"/dist/arm64/* "$TOOLS_DIR/linux-arm64/"

# and we're done!

rm -rf "$TOOLS_DIR/dist"
