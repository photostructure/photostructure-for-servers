#!/bin/bash
# Copyright © 2026, PhotoStructure Inc.

# BY RUNNING THIS SOFTWARE YOU AGREE TO ALL THE TERMS OF THIS LICENSE:
# https://photostructure.com/eula

DIR="$(dirname "$(realpath "$0")")"/
exec "$DIR"/photostructure --stop "$@"
