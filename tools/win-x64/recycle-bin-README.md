# recycle-bin

Built locally from release v2.1.1, commit
[`8ff31a43af7e181c22958795d04805ba3db36054`](https://github.com/sindresorhus/recycle-bin/commit/8ff31a43af7e181c22958795d04805ba3db36054).
The downloaded source archive SHA-256 was
`6711127c20457822aca2ecf2d01ecfa16dc4153acb1cc8193fffd44654700067`.

```bat
build-msvc.bat x86_64
```

The upstream script used Visual Studio 2022 Developer Command Prompt 17.14.27
and Microsoft C/C++ compiler 19.44.35223. The resulting `recycle-bin.exe`
SHA-256 is `306eb286d958996c890b1a00312dd216a0492227807c638d08cc4e7fdb5a8a01`.

`dumpbin` reports an x64 PE executable with only `ole32.dll`, `SHELL32.dll`,
and `KERNEL32.dll` dependencies. `--help` passed, and a disposable file was
successfully moved to the Windows Recycle Bin. This file was compiled locally,
so the downloaded-binary VirusTotal requirement does not apply.
