#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

set -x

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest@sha256:7f41145ec11b8465327d9f8006586f0a0f93a7b1405076321ab51a870e907215

docker run \
  --rm \
  --net=host \
  --volume "${ACME_HOME:-$(pwd)/acme.sh}":/acme.sh \
  --env-file "${GLOBAL_ENV_FILE}" \
  --env-file "${ENV_FILE}" \
  "neilpang/acme.sh:${IMAGE_VERSION}" "$@"
