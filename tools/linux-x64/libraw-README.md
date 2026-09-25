# Linux x64 LibRaw tools

- LibRaw 0.22.2 source commit: `b93f6e45c194f5df9b02a43b1af9a54b4f41f33f`.
- Build: `base-tools-debian` commit `27a782e` on Debian trixie with GCC 14.2.0. In that repository, run `docker build --target builder -t base-tools-debian:test .`; its Dockerfile configures LibRaw with `--enable-static --disable-lcms --disable-openmp` and links both tools with `-all-static`. Extract the published image with `bash tools/build.sh` in PhotoStructure.
- `dcraw_emu` SHA-256: `a6e566bbd0887909f8cae74d4d05ebc0d7445fd7854ccd9da2bf202851e83139`.
- `raw-identify` SHA-256: `fdaff814919d6449c1f36e6788ba967d17200061e50afdbe743ffb0887567afd`.
- Verified against the previous producer image with the `base-tools-debian` regression corpus.
