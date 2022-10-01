#!/bin/bash
set -x

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest

docker run --rm "neilpang/acme.sh:${IMAGE_VERSION}" "$@"
