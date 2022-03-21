#!/bin/bash
set -x

docker-compose down

CONTAINER_LOGS=/docker_output.log
if [[ -z "${CONTAINER_LOGS}" ]]; then
  cat "${CONTAINER_LOGS}"
else
  echo "No container logs found at \"${CONTAINER_LOGS}\""
fi
