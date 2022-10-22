#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p "${SNAP_DATA}/config/"
# SNAP_DATA is backed up and restored across snap refresh and snap revert operations
"$SNAP/bin/consul" agent -config-dir="${SNAP_DATA}/config/"
