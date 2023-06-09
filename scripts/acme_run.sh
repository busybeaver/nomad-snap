#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest@sha256:9556a6310e59c54b37ab02916d6eaed5fc0280465051827150ebe2bb253fca15

docker run \
  --rm \
  --net=host \
  --volume "${ACME_HOME:-$(pwd)/output}":/acme.sh \
  --env-file "${GLOBAL_ENV_FILE}" \
  --env-file "${ENV_FILE}" \
  "neilpang/acme.sh:${IMAGE_VERSION}" "$@"
