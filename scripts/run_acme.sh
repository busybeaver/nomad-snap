#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

set -x

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest@sha256:9284edb3533ab27cc99a0b1fe17e3ae36ca248a1bdcd40f0794390bcb036384d

docker run --rm "neilpang/acme.sh:${IMAGE_VERSION}" "$@"
