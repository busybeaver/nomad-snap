#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

LC_ALL=C

shopt -s nocasematch
if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi
shopt -u nocasematch

echo "update_docker_socks.sh script started at $(date)"

# change group of the docker.sock, so selected users can access/use it properly and without user elevation
chgrp docker-sock-users /var/run/docker.sock

echo "update_docker_socks.sh script finished successfully at $(date)"
