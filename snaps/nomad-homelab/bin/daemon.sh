#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p "${SNAP_DATA}/config/"
# SNAP_DATA is backed up and restored across snap refresh and snap revert operations
"$SNAP/bin/nomad" agent -config="${SNAP_DATA}/config/"
