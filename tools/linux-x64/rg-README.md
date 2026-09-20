# ripgrep

Version 15.2.0, extracted from the official
[`ripgrep-15.2.0-x86_64-unknown-linux-musl.tar.gz`](https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/ripgrep-15.2.0-x86_64-unknown-linux-musl.tar.gz).

- Archive SHA-256: `33e15bcf1624b25cdd2a55813a47a2f95dbe126268203e76aa6a585d1e7b149c`
- `rg` SHA-256: `e62198eb19b136b88c330af83647b5a962cb99b6b1f066758568f12de1974849`

The musl target is deliberate: it produces a `static-pie` executable with no
dynamic dependencies, so it runs on any glibc or musl distribution PhotoStructure
for Node supports.

## Reproduce

```sh
PROJECT_ROOT=$(git rev-parse --show-toplevel)
"$PROJECT_ROOT/tools/download-rg.sh" 15.2.0
```

`download-rg.sh` refreshes every platform at once. Pass no version to take
whatever upstream currently marks latest.

## Verification

- `file` reports an x86-64 ELF `static-pie linked, stripped`; `ldd` reports
  `statically linked`.
- `rg --version` reports `ripgrep 15.2.0 (rev e89fff89ac)` with `+pcre2` and
  PCRE2 10.45 (JIT available).
- `rg -Fc ripgrep tools/README.md` returned the expected match.
