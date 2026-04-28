# syntax=docker/dockerfile:1

# All static tool binaries (LibRaw, SQLite, jpegtran) are built by
# base-tools-debian. This Dockerfile just extracts them for Desktop/Node
# editions.
#
# This tag must match what Dockerfile.test and server/Dockerfile use.
# https://github.com/photostructure/base-tools-debian
FROM photostructure/base-tools-debian:sha-99c3fd8 AS base-tools

FROM scratch AS export-stage
COPY --from=base-tools /opt/photostructure/tools .
