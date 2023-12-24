#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

curl -Ls --proto "=https" --tlsv1.3 --http3 --retry 3 https://cli.doppler.com/install.sh | sudo sh
