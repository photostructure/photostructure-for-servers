#!/bin/sh
# Install codec tools (FFmpeg, libheif) inside the PhotoStructure Docker
# image via the distro package manager. Consent-gated: the PhotoStructure
# web service calls this after the user clicks Yes on /welcome/tools, and
# docker-entrypoint.sh calls it on container start when the consent file
# from a prior install is present but the tools are missing (e.g. after a
# `docker pull` to a newer base image).
#
# Security posture: this script is root-owned, 0755, takes no arguments,
# and is the sole command authorized by /etc/sudoers.d/photostructure-
# codec-install for the `photostructure` user. No user-controlled input
# reaches apt-get.
#
# See docs/patent-licensing-policy.md — we facilitate installation via the
# user's OS package manager (Rule 4) but never ship codec binaries
# ourselves (Rule 1).

set -eu

# Idempotent no-op when the tools are already on PATH. libheif ≥ 1.18
# renamed heif-convert → heif-dec (Debian keeps the old name as a symlink
# for backward compat). Probe the new name first to match HeifConvert.ts.
if command -v ffmpeg >/dev/null 2>&1 &&
  { command -v heif-dec >/dev/null 2>&1 ||
    command -v heif-convert >/dev/null 2>&1; }; then
  echo "ffmpeg and libheif already installed; nothing to do"
  exit 0
fi

# Trixie ships libheif 1.19.x and ffmpeg 7.1.x natively, so no backports
# wiring is needed — plain `apt-get install` from the distro suffices.
#
# `apt-get update` is required: the base Dockerfile runs
# `rm -rf /var/lib/apt/lists/*` after its own install step to shrink the
# image, so every codec-install invocation (first-run OR entrypoint
# auto-restore after `docker pull`) starts with an empty apt index and
# would fail with "Unable to locate package" without a fresh update.
echo "Running apt-get update..."
apt-get update

echo "Installing ffmpeg and libheif..."
apt-get install -y --no-install-recommends \
  ffmpeg heif-thumbnailer libheif-examples

# Shrink the image: drop the apt cache.
rm -rf /var/lib/apt/lists/*

echo "install-codec-tools.sh: done"
