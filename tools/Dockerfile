# syntax=docker/dockerfile:1

# All static tool binaries (LibRaw, SQLite, jpegtran) are built by
# base-tools-debian. This Dockerfile just extracts them for Desktop/Node
# editions.
#
# https://github.com/photostructure/base-tools-debian
# base-tools-debian c2c003c. Digest, not tag: bump per PREFLIGHT-DEPS.md.
FROM photostructure/base-tools-debian@sha256:35dc01cb08e76bb563d81c2f67ae5403d5fe0179789870cf7093edfb4111076b AS base-tools

FROM scratch AS export-stage
COPY --from=base-tools /opt/photostructure/tools .
