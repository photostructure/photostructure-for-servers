# jpegtran

Version 3.2.0 (build 20260630), installed from the official
[`libjpeg-turbo-3.2.0-gcc-x64.exe`](https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/3.2.0/libjpeg-turbo-3.2.0-gcc-x64.exe).
The installer SHA-256 is
`5a71ea596c573ea3b44c8e7b5e78613d3a28dc9490dc714e7222c9f63f55e454`,
and its Authenticode signature from SignPath Foundation was valid.

Use the **gcc-x64** installer. It provides the required `libjpeg-62.dll`; the
VC build provides `jpeg62.dll`, which does not satisfy `jpegtran.exe`'s import.

- `jpegtran.exe` SHA-256: `a90d8c20128fcb6a762f704fd011f22159a053a372c9e71f603d88b7c93b084d`
  ([VirusTotal: 0/69 detections](https://www.virustotal.com/gui/file/a90d8c20128fcb6a762f704fd011f22159a053a372c9e71f603d88b7c93b084d))
- `libjpeg-62.dll` SHA-256: `3493ce5a6b0615b44ad8475ee060bd5c965069809a9dc2453b6503af55b9c65e`
  ([VirusTotal: 0/70 detections](https://www.virustotal.com/gui/file/3493ce5a6b0615b44ad8475ee060bd5c965069809a9dc2453b6503af55b9c65e))

`dumpbin` reports x64 PE files. `jpegtran.exe` depends only on `KERNEL32.dll`,
`msvcrt.dll`, and `libjpeg-62.dll`; the DLL depends only on `KERNEL32.dll` and
`msvcrt.dll`. It does not require `libturbojpeg.dll`.

Verified the exact stderr version string, JPEG validation, a lossless 90-degree
rotation, validation of the rotated output, and nonzero failures for a non-JPEG
(`Not a JPEG file`) and truncated JPEG (`Premature end of JPEG file`).
