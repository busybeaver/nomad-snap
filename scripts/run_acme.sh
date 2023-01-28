#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

set -x

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest@sha256:30bf4ea471d331d7df54cd8575660ee23e4e81da63ecb5e64e8652c48a135291

docker run --rm "neilpang/acme.sh:${IMAGE_VERSION}" "$@"
