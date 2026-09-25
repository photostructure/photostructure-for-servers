#!/usr/bin/env bash
set -euo pipefail

# The Node and Desktop editions run this binary against the host's glibc/NSS.
# Ubuntu 24.04 with passwd: compat exposed a static-glibc crash in 2026.9.5.
tools_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sqlite3="${1:-$tools_dir/linux-x64/sqlite3}"
sqlite3="$(cd "$(dirname "$sqlite3")" && pwd)/$(basename "$sqlite3")"
platform="${2:-linux/amd64}"

docker run --rm --network none --platform "$platform" --ulimit core=0 \
  --mount "type=bind,src=$sqlite3,dst=/sqlite3,readonly" \
  ubuntu:24.04 sh -ec '
    sed -i "s/^passwd:.*/passwd: compat/" /etc/nsswitch.conf
    grep -q "^passwd: compat$" /etc/nsswitch.conf
    /sqlite3 -version
    test "$(/sqlite3 :memory: "select 1")" = 1
  '
