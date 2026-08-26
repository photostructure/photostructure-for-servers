# LibRaw

Version 0.22.2, extracted from the official
[`LibRaw-0.22.2-Win64.zip`](https://www.libraw.org/data/LibRaw-0.22.2-Win64.zip).
The archive SHA-256 is
`ac64fa12bb00a7581332d4c6ab918c0533fb3f119d6b668d47a6875410dca948`.

- `dcraw_emu.exe` SHA-256: `8df090a80c784fa03182b91ab1679fd08e5fc139d54b0bfb8b003024ef741129`
  ([VirusTotal: 0/69 detections](https://www.virustotal.com/gui/file/8df090a80c784fa03182b91ab1679fd08e5fc139d54b0bfb8b003024ef741129))
- `raw-identify.exe` SHA-256: `c6d9f0fe34e39a4faa87380821479a0fb2cc77715f3dd90b07599f8f293e2a1b`
  ([VirusTotal: 0/70 detections](https://www.virustotal.com/gui/file/c6d9f0fe34e39a4faa87380821479a0fb2cc77715f3dd90b07599f8f293e2a1b))
- `libraw.dll` SHA-256: `6a459c22039abf0eac4d263673337c8ed5f223acbd372fcf77610debf80ac8cd`
  ([VirusTotal: 0/69 detections](https://www.virustotal.com/gui/file/6a459c22039abf0eac4d263673337c8ed5f223acbd372fcf77610debf80ac8cd))

`dumpbin` reports x64 PE files. The executables depend on `libraw.dll`, the
Microsoft C++ runtime, the Universal CRT, and Windows system DLLs. The DLL has
only Microsoft runtime and Windows system dependencies and does not import an
OpenMP runtime.

Validated with `examples/Raw/Canon_T3i.CR2`: `raw-identify` recognized a Canon
EOS 600D, and `dcraw_emu -T -h -w` produced a 13,516,668-byte TIFF.
