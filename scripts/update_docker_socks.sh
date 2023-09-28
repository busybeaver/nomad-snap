#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

# change group of the docker.sock, so selected users can access/use it properly and without user elevation
chgrp docker-sock-users /var/run/docker.sock
