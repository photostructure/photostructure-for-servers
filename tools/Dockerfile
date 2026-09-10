# syntax=docker/dockerfile:1

# All static tool binaries (LibRaw, SQLite, jpegtran) are built by
# base-tools-debian. This Dockerfile just extracts them for Desktop/Node
# editions.
#
# https://github.com/photostructure/base-tools-debian
# base-tools-debian 3d3b057. Digest, not tag: bump per PREFLIGHT-DEPS.md.
FROM photostructure/base-tools-debian@sha256:69e6b13a45454d6188f04dfcc2c90d1270ee22d2564460d092a487e36e4693c2 AS base-tools

FROM scratch AS export-stage
COPY --from=base-tools /opt/photostructure/tools .
