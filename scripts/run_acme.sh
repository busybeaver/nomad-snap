#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

set -x

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest@sha256:9bc84683c8344647e37b7ba6116652e47faad9bb6f18d0f9284e7a1c7413e204

docker run --rm "neilpang/acme.sh:${IMAGE_VERSION}" "$@"
