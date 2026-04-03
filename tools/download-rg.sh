#!/bin/bash -e

# Download ripgrep binaries from BurntSushi/ripgrep (upstream).
# Mirrors the platform naming used by tools/{linux-x64,linux-arm64,mac-x64,mac-arm64,win-x64}.
#
# Usage:
#   ./download-rg.sh          # auto-detect latest version
#   ./download-rg.sh 15.1.0   # pin to specific version

REPO="BurntSushi/ripgrep"

if [ -n "$1" ]; then
  VERSION="$1"
else
  echo "Fetching latest release tag from ${REPO}..."
  VERSION="$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" |
    grep '"tag_name"' | sed -E 's/.*"tag_name": *"([^"]+)".*/\1/')"
  if [ -z "$VERSION" ]; then
    echo "ERROR: Could not determine latest version. Pass explicitly, e.g.: $0 15.1.0" >&2
    exit 1
  fi
  echo "Latest version: ${VERSION}"
fi

BASE_URL="https://github.com/${REPO}/releases/download/${VERSION}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

# download_rg <platform-dir> <archive-name> <binary-name>
download_rg() {
  local platform="$1" archive="$2" binary="$3"
  local url="${BASE_URL}/${archive}"
  local dest="${SCRIPT_DIR}/${platform}"

  echo "=== ${platform}: ${archive} ==="
  curl -fsSL -o "${TMPDIR}/${archive}" "${url}"

  if [[ "$archive" == *.tar.gz ]]; then
    # Upstream tarballs have a nested directory: ripgrep-VERSION-TARGET/rg
    tar -xzf "${TMPDIR}/${archive}" -C "${TMPDIR}" --strip-components=1 --wildcards "*/${binary}"
  elif [[ "$archive" == *.zip ]]; then
    unzip -o -j "${TMPDIR}/${archive}" "*/${binary}" -d "${TMPDIR}"
  fi

  mv "${TMPDIR}/${binary}" "${dest}/${binary}"
  chmod +x "${dest}/${binary}"
  echo "  -> ${dest}/${binary}"
}

# Platform map: directory → archive target → binary name
# linux-x64 uses musl (fully static). linux-arm64 uses glibc (Debian Docker).
download_rg linux-x64 "ripgrep-${VERSION}-x86_64-unknown-linux-musl.tar.gz" rg
download_rg linux-arm64 "ripgrep-${VERSION}-aarch64-unknown-linux-gnu.tar.gz" rg
download_rg mac-x64 "ripgrep-${VERSION}-x86_64-apple-darwin.tar.gz" rg
download_rg mac-arm64 "ripgrep-${VERSION}-aarch64-apple-darwin.tar.gz" rg
download_rg win-x64 "ripgrep-${VERSION}-x86_64-pc-windows-msvc.zip" rg.exe

echo ""
echo "Done. Verify with: file ${SCRIPT_DIR}/linux-x64/rg"
