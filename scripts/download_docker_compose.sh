#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

shopt -s extglob

# renovate: datasource=docker depName=mikefarah/yq versioning=docker
YQ_IMAGE_VERSION=4.40.5@sha256:32be61dc94d0acc44f513ba69d0fc05f1f92c2e760491f2a27e11fc13cde6327

# renovate: datasource=docker depName=bitnami/cosign versioning=docker
COSIGN_IMAGE_VERSION=1.13.1@sha256:0cede189f264e3939020acd5333d5854fcb60c372cb7f30d7deaefff57ee2965

GIT_REPO_PATH="${GIT_ORG}/${GIT_REPOSITORY}"

cd "${CHECKOUT_DIRECTORY:-.}" || exit 1
rm -rf .[!.]* docker-compose.yaml public_key

# requires SSH key or deploy key present
git clone --branch main --single-branch --depth 1 --filter=blob:limit=1m "git@github.com:${GIT_REPO_PATH}.git" .
# ".[!.]*" matches all dot files except "." and files whose name begins with ".." // https://unix.stackexchange.com/a/77313
# "!(docker-compose.yaml|public_key)" matches all non dot files except the docker-compose.yaml file and public_key folder (requires "extglob")
rm -rf .[!.]* !(docker-compose.yaml|public_key)

# extract images from docker-compose.yaml file
DOCKER_COMPOSE_IMAGES=$(docker run \
  --rm \
  --interactive \
  --security-opt=no-new-privileges \
  --cap-drop all \
  --network none \
  "mikefarah/yq:${YQ_IMAGE_VERSION}" '.services.[].image' <docker-compose.yaml)

printf "The docker-compose.yaml file specifies the following Docker images:\n%s\n\n" "${DOCKER_COMPOSE_IMAGES}"

echo "Verify the public sign key: public_key/cosign.pub"
DOCKER_CONTENT_TRUST=1 docker run \
  --rm \
  --interactive \
  --security-opt=no-new-privileges \
  --cap-drop all \
  --network none \
  --volume "${PUBLIC_KEY_DIRECTORY:-$(pwd)/public_key}":/public_key:ro \
  "bitnami/cosign:${COSIGN_IMAGE_VERSION}" verify-blob --key /public_key/cosign.pub --signature /public_key/cosign.pub.sig /public_key/cosign.pub

echo "Verify the signature of the docker images"
for DOCKER_COMPOSE_IMAGE in ${DOCKER_COMPOSE_IMAGES}; do
  # we can only verify the signature of our own images
  if [[ "${DOCKER_COMPOSE_IMAGE}" =~ ^ghcr\.io\/busybeaver\/homelab-packages\/.* ]]; then
    echo "Check signature for image: ${DOCKER_COMPOSE_IMAGE}"
    DOCKER_CONTENT_TRUST=1 docker run \
      --rm \
      --interactive \
      --security-opt=no-new-privileges \
      --cap-drop all \
      --volume "${PUBLIC_KEY_DIRECTORY:-$(pwd)/public_key}":/public_key:ro \
      "bitnami/cosign:${COSIGN_IMAGE_VERSION}" verify --key /public_key/cosign.pub --annotations "repo=${GIT_REPO_PATH}" --output text "${DOCKER_COMPOSE_IMAGE}"
  else
    echo "Skipping signature check for image: ${DOCKER_COMPOSE_IMAGE}"
  fi
done
