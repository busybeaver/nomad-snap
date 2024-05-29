#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

set -x

# this isn't strictly necessary to stop the service since we shut down the instance afterwards anyways;
# it's more of a check that the service shutdown works fine
sudo snap stop "${SERVICE_NAME}.daemon"
sleep 10s
