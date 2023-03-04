#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

set -x

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest@sha256:e9139e0190c7805c3f228fa6dff6a2464771e558285a2efbf204c4a8664c1abd

docker run --rm "neilpang/acme.sh:${IMAGE_VERSION}" "$@"
