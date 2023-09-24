#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest@sha256:3ec83e8f3e756ccef1db6e691313dfc7bf11b219c1d60a13797255d7d6bb2eda

docker run \
  --rm \
  --net=host \
  --volume "${ACME_HOME:-$(pwd)/output}":/acme.sh \
  --env-file "${GLOBAL_ENV_FILE}" \
  --env-file "${ENV_FILE}" \
  "neilpang/acme.sh:${IMAGE_VERSION}" "$@"
