#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

echo "acme_init.sh script started at $(date)"

HOMELAB_PACKAGES_CONFIG="${HOMELAB_PACKAGES_CONFIG_FOLDER:-~/homelab-packages-config}"

# general setup
export CERT_DNS="dns_cf"
export ACME_DIRECTORY_RESOURCE="letsencrypt"
export ACME_HOME="${HOMELAB_PACKAGES_CONFIG}/acme.sh"
export GLOBAL_ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/cf.env"

# synology nas
export CERT_DOMAIN="nas1.mollner.cloud"
export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/syno.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"
# bash scripts/acme_run.sh --deploy --domain "$CERT_DOMAIN" --deploy-hook synology_dsm --insecure

# adguard
export CERT_DOMAIN_1="adguard1.mollner.cloud"
export CERT_DOMAIN_2="dns1.mollner.cloud"
export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/adguard.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN_1" --domain "$CERT_DOMAIN_2" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}" --post-hook "set -x && cp \$CERT_KEY_PATH /volume_base_directory/adguard/conf/certs/cert.key && cp \$CERT_PATH /volume_base_directory/adguard/conf/certs/cert.cer && chown -R ${ADGUARD_USER}:${DOCKER_USER_GROUP} /volume_base_directory/adguard/conf/certs" --force

# uptime-kuma
export CERT_DOMAIN="uptime.mollner.cloud"
export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/uptime-kuma.env"
bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}" --post-hook "set -x && cp \$CERT_KEY_PATH /volume_base_directory/uptime-kuma/cert/cert.key && cp \$CERT_PATH /volume_base_directory/uptime-kuma/cert/cert.cer && chown -R ${UPTIME_KUMA_USER}:${DOCKER_USER_GROUP} /volume_base_directory/uptime-kuma/cert" --force

# homebridge
export CERT_DOMAIN="homebridge.mollner.cloud"
export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/homebridge.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"

# n8n
export CERT_DOMAIN="n8n.mollner.cloud"
export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/n8n.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"

# node-red
export CERT_DOMAIN="node-red.mollner.cloud"
export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/node-red.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"

echo "acme_init.sh script finished successfully at $(date)"
