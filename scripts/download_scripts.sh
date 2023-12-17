#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

shopt -s extglob

# renovate: datasource=docker depName=bitnami/cosign versioning=docker
COSIGN_IMAGE_VERSION=1.13.1@sha256:0cede189f264e3939020acd5333d5854fcb60c372cb7f30d7deaefff57ee2965

cd "${CHECKOUT_DIRECTORY:-.}" || exit 1
rm -rf .[!.]* scripts

git clone --branch main --single-branch --depth 1 --filter=blob:limit=1m "https://github.com/busybeaver/${GIT_REPOSITORY:-homelab-packages}.git" .

echo "Verify the public sign key: public_key/cosign.pub"
DOCKER_CONTENT_TRUST=1 docker run \
  --rm \
  --interactive \
  --security-opt=no-new-privileges \
  --cap-drop all \
  --network none \
  --volume "${PUBLIC_KEY_DIRECTORY:-$(pwd)/public_key}":/public_key:ro \
  "bitnami/cosign:${COSIGN_IMAGE_VERSION}" verify-blob --key /public_key/cosign.pub --signature /public_key/cosign.pub.sig /public_key/cosign.pub

echo "Verify the checksum file: scripts/scripts.sha256"
DOCKER_CONTENT_TRUST=1 docker run \
  --rm \
  --interactive \
  --security-opt=no-new-privileges \
  --cap-drop all \
  --network none \
  --volume "${PUBLIC_KEY_DIRECTORY:-$(pwd)/public_key}":/public_key:ro \
  --volume "${SCRIPTS_DIRECTORY:-$(pwd)/scripts}":/scripts:ro \
  "bitnami/cosign:${COSIGN_IMAGE_VERSION}" verify-blob --key /public_key/cosign.pub --signature /scripts/scripts.sha256.sig /scripts/scripts.sha256

echo "Check the script checksums"
( cd ./scripts && sha256sum -c scripts.sha256 )

# ".[!.]*" matches all dot files except "." and files whose name begins with ".." // https://unix.stackexchange.com/a/77313
# "!(scripts)" matches all non dot files except the scripts folder (requires "extglob")
rm -rf .[!.]* !(scripts)
