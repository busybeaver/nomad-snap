#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest@sha256:ae7c0d1138e0499f45cb8ebf65fdc31dd3c1247d7e9841fe0ec97501493435cf

docker run \
  --rm \
  --net=host \
  --volume "${ACME_HOME:-$(pwd)/output}":/acme.sh \
  --env-file "${GLOBAL_ENV_FILE}" \
  --env-file "${ENV_FILE}" \
  "neilpang/acme.sh:${IMAGE_VERSION}" "$@"
