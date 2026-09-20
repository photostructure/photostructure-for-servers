# ripgrep

Version 15.2.0, extracted from the official
[`ripgrep-15.2.0-x86_64-pc-windows-msvc.zip`](https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/ripgrep-15.2.0-x86_64-pc-windows-msvc.zip).

- Archive SHA-256: `71b2fef860abe467217a538ff31de02f5258807c0129f771846f87bd029aafc5`
- `rg.exe` SHA-256: `14231169855ec5205cf5a1b6f1db358ff4aed4247c86b69ce8aae647c77f6680`
- [VirusTotal: 0/62 detections](https://www.virustotal.com/gui/file/14231169855ec5205cf5a1b6f1db358ff4aed4247c86b69ce8aae647c77f6680)

`dumpbin` reports an x64 PE executable with only Windows system DLL
dependencies. `rg --version` reported 15.2.0 with PCRE2 10.45, and a real
repository search returned the expected match.
