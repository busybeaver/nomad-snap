#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

LC_ALL=C

shopt -s nocasematch
if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi
shopt -u nocasematch

echo "acme_init.sh script started at $(date)"

HOMELAB_PACKAGES_CONFIG="${HOMELAB_PACKAGES_CONFIG_FOLDER:-~/homelab-packages-config}"

# note: unifi is running ssl cert updates on its own

# general setup
export CERT_DNS="dns_cf"
export ACME_DIRECTORY_RESOURCE="letsencrypt"
export ACME_HOME="${HOMELAB_PACKAGES_CONFIG}/acme.sh"
export GLOBAL_ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/cf.env"

# synology nas
if [ "${INIT_SYNOLOGY^^}" == "TRUE" ]; then
  export CERT_DOMAIN_1="nas1.${ROOT_DOMAIN}"
  export CERT_DOMAIN_2="synology1.${ROOT_DOMAIN}"
  export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/syno.env"
  bash scripts/acme_run.sh --issue --domain "${CERT_DOMAIN_1}" --domain "${CERT_DOMAIN_2}" --dns "${CERT_DNS}" --server "${ACME_DIRECTORY_RESOURCE}"
  bash scripts/acme_run.sh --deploy --domain "${CERT_DOMAIN_1}" --domain "${CERT_DOMAIN_2}" --deploy-hook synology_dsm --insecure
fi

# fritz!box
if [ "${INIT_FRITZ_BOX^^}" == "TRUE" ]; then
  export CERT_DOMAIN_1="fritz-box.${ROOT_DOMAIN}"
  export CERT_DOMAIN_2="router.${ROOT_DOMAIN}"
  export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/fritz-box.env"
  bash scripts/acme_run.sh --issue --domain "${CERT_DOMAIN_1}" --domain "${CERT_DOMAIN_2}" --dns "${CERT_DNS}" --server "${ACME_DIRECTORY_RESOURCE}"
  bash scripts/acme_run.sh --deploy --domain "${CERT_DOMAIN_1}" --domain "${CERT_DOMAIN_2}" --deploy-hook fritzbox --insecure
fi

# adguard
if [ "${INIT_ADGUARD^^}" == "TRUE" ]; then
  export CERT_DOMAIN_1="adguard1.${ROOT_DOMAIN}"
  export CERT_DOMAIN_2="dns1.${ROOT_DOMAIN}"
  export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/adguard.env"
  bash scripts/acme_run.sh --issue --domain "${CERT_DOMAIN_1}" --domain "${CERT_DOMAIN_2}" --dns "${CERT_DNS}" --server "${ACME_DIRECTORY_RESOURCE}" \
    --renew-hook "set -x && cp \$CERT_KEY_PATH /volume_base_directory/adguard/conf/certs/cert.key && cp \$CERT_PATH /volume_base_directory/adguard/conf/certs/cert.cer && chown -R ${ADGUARD_USER}:${DOCKER_USER_GROUP} /volume_base_directory/adguard/conf/certs"
fi

# uptime-kuma
if [ "${INIT_UPTIME_KUMA^^}" == "TRUE" ]; then
  export CERT_DOMAIN_1="uptime.${ROOT_DOMAIN}"
  export CERT_DOMAIN_2="status.${ROOT_DOMAIN}"
  export CERT_DOMAIN_3="health.${ROOT_DOMAIN}"
  export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/uptime-kuma.env"
  bash scripts/acme_run.sh --issue --domain "${CERT_DOMAIN_1}" --domain "${CERT_DOMAIN_2}" --domain "${CERT_DOMAIN_3}" --dns "${CERT_DNS}" --server "${ACME_DIRECTORY_RESOURCE}" \
    --renew-hook "set -x && cp \$CERT_KEY_PATH /volume_base_directory/uptime-kuma/cert/cert.key && cp \$CERT_PATH /volume_base_directory/uptime-kuma/cert/cert.cer && chown -R ${UPTIME_KUMA_USER}:${DOCKER_USER_GROUP} /volume_base_directory/uptime-kuma/cert"
fi

# homebridge
if [ "${INIT_HOMEBRIDGE^^}" == "TRUE" ]; then
  export CERT_DOMAIN="homebridge.${ROOT_DOMAIN}"
  export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/homebridge.env"
  bash scripts/acme_run.sh --issue --domain "${CERT_DOMAIN}" --dns "${CERT_DNS}" --server "${ACME_DIRECTORY_RESOURCE}"
fi

# n8n
if [ "${INIT_N8N^^}" == "TRUE" ]; then
  export CERT_DOMAIN="n8n.${ROOT_DOMAIN}"
  export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/n8n.env"
  bash scripts/acme_run.sh --issue --domain "${CERT_DOMAIN}" --dns "${CERT_DNS}" --server "${ACME_DIRECTORY_RESOURCE}"
fi

# node-red
if [ "${INIT_NODE_RED^^}" == "TRUE" ]; then
  export CERT_DOMAIN_1="node-red.${ROOT_DOMAIN}"
  export CERT_DOMAIN_2="status.${ROOT_DOMAIN}"
  export ENV_FILE="${HOMELAB_PACKAGES_CONFIG}/env_files/node-red.env"
  bash scripts/acme_run.sh --issue --domain "${CERT_DOMAIN_1}" --domain "${CERT_DOMAIN_2}" --dns "${CERT_DNS}" --server "${ACME_DIRECTORY_RESOURCE}" \
    --renew-hook "set -x && cp \$CERT_KEY_PATH /volume_base_directory/node-red/cert/cert.key && cp \$CERT_PATH /volume_base_directory/node-red/cert/cert.cer && chown -R ${NODE_RED_USER}:${DOCKER_USER_GROUP} /volume_base_directory/node-red/cert"
fi

echo "acme_init.sh script finished successfully at $(date)"
