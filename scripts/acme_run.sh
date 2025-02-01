#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

LC_ALL=C

shopt -s nocasematch
if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi
shopt -u nocasematch

echo "acme_run.sh script started at $(date)"

# renovate: datasource=docker depName=neilpang/acme.sh versioning=docker
IMAGE_VERSION=latest@sha256:65f27a543c912b6b884ca1d0d76a06e87ba5fb78efcb6f695a80472a585261b1

docker run \
  --rm \
  --net=host \
  --volume "${ACME_HOME:-$(pwd)/output}":/acme.sh \
  --volume "${VOLUME_BASE_DIRECTORY:-$(pwd)/volume_base_directory}":/volume_base_directory \
  --env-file "${GLOBAL_ENV_FILE}" \
  --env-file "${ENV_FILE}" \
  "neilpang/acme.sh:${IMAGE_VERSION}" "$@"

echo "acme_run.sh script finished successfully at $(date)"
