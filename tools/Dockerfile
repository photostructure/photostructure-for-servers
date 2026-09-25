# syntax=docker/dockerfile:1

# All Linux tool binaries (LibRaw, SQLite, jpegtran) come from the pinned
# base-tools-debian image. This Dockerfile extracts them for Desktop/Node.
# https://github.com/photostructure/base-tools-debian

# base-tools-debian 27a782e. Digest, not tag: bump per PREFLIGHT-DEPS.md.
FROM photostructure/base-tools-debian@sha256:243a928f1b3d087f7943de8d1e12747fbe976cfc2c57912436235ed446f43760 AS base-tools

FROM scratch AS export-stage
COPY --from=base-tools /opt/photostructure/tools .
