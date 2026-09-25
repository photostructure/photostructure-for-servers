# Linux arm64 jpegtran

- libjpeg-turbo 3.2.0 source commit: `c85e6b905bf237038faa936dab160ebfc5da0344`.
- Build: `base-tools-debian` commit `27a782e` on Debian trixie with GCC 14.2.0. Its Dockerfile runs `cmake -G "Unix Makefiles" -DENABLE_SHARED=0 -DENABLE_STATIC=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="-static" -DCMAKE_EXE_LINKER_FLAGS="-static"`, then `make -j $(nproc) jpegtran-static` and `strip`. Extract with `bash tools/build.sh`.
- Binary SHA-256: `c6c4ca3a746b46ce25747a55cdacf12770a4482e8756646dc5652b4ca5dffc34`.
- Verified with `jpegtran -version` and the `base-tools-debian` regression corpus against the previous image.
