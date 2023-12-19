#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

echo "acme_cron.sh script started at $(date)"

HOMELAB_PACKAGES_CONFIG="${HOMELAB_PACKAGES_CONFIG_FOLDER:-~/homelab-packages-config}"

# general setup
export ACME_HOME="${HOMELAB_PACKAGES_CONFIG}/acme.sh"

# refresh all certificates
bash scripts/acme_run.sh --cron --insecure

echo "acme_cron.sh script finished successfully at $(date)"
