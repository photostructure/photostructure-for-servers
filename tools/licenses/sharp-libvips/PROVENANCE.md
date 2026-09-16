# Patched sharp/libvips notices

PhotoStructure's Linux desktop build uses sharp 0.35.4 and a patched libvips
8.18.6 from https://github.com/photostructure/sharp-electron/tree/v0.35.4-ps.1.
The fork retains upstream authorship and contains build instructions and patches.

The component inventory is copied unchanged from that build's
`dist/linux-x64/THIRD-PARTY-NOTICES.md`. Its upstream source is
https://github.com/lovell/sharp-libvips/blob/6e5971d333377743163edc3ad9e5d0b897abcbc9/THIRD-PARTY-NOTICES.md.

The inventory selects LGPLv3 through the libraries' later-version clauses.
`LGPL-3.txt` and `GPL-3.txt` are unmodified GNU license texts. The additional
GPL text accompanies LGPLv3 as required by LGPLv3 section 4(b); it does not
relicense PhotoStructure under the GPL.

`bin/mklicenses.sh` includes this directory even though the patched installation
removes the original sharp-libvips npm package. Keep these notices and the
component inventory current when the pinned build changes.
