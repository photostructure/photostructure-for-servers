# Linux arm64 LibRaw tools

- LibRaw 0.22.2 source commit: `b93f6e45c194f5df9b02a43b1af9a54b4f41f33f`.
- Build: `base-tools-debian` commit `27a782e` on Debian trixie with GCC 14.2.0. In that repository, run `docker build --target builder -t base-tools-debian:test .`; its Dockerfile configures LibRaw with `--enable-static --disable-lcms --disable-openmp` and links both tools with `-all-static`. Extract the published image with `bash tools/build.sh` in PhotoStructure.
- `dcraw_emu` SHA-256: `b10e1f8551dcc3d275b2a7c9b99c6de40564a8b9bedca71aa98ed543391be998`.
- `raw-identify` SHA-256: `04e03749f37a4064c5e71ababe42697ff3348f521fcd05ab2b1b204cbf6e0b58`.
- Verified against the previous producer image with the `base-tools-debian` regression corpus.
