cd /volume1/homes/busybeaver42/homelab-packages/

# general setup
CONF_FOLDER="/volume1/homes/busybeaver42/homelab-packages-config"
export CERT_DNS="dns_cf"
export ACME_DIRECTORY_RESOURCE="letsencrypt"
export ACME_HOME="${CONF_FOLDER}/acme.sh"
export GLOBAL_ENV_FILE="${CONF_FOLDER}/env_files/cf.env"

# synology nas
export CERT_DOMAIN="nas.internal.mollner.cloud"
export ENV_FILE="${CONF_FOLDER}/env_files/syno.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"
# bash scripts/acme_run.sh --deploy --domain "$CERT_DOMAIN" --deploy-hook synology_dsm --insecure

# unifi
export CERT_DOMAIN="network.internal.mollner.cloud"
export ENV_FILE="${CONF_FOLDER}/env_files/unifi.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"
# bash scripts/acme_run.sh --deploy --domain "$CERT_DOMAIN" --deploy-hook ssh

# adguard
export CERT_DOMAIN_1="adguard1.internal.mollner.cloud"
export CERT_DOMAIN_2="dns1.internal.mollner.cloud"
export ENV_FILE="${CONF_FOLDER}/env_files/adguard.env"
bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN_1" --domain "$CERT_DOMAIN_2" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}" --post-hook "set -x && id && cp \$CERT_KEY_PATH /volume1/docker/adguard/conf/cert.key && cp \$CERT_PATH /volume1/docker/adguard/conf/cert.cer && docker restart internal_adguard-home" --force

# homeassistant
export CERT_DOMAIN_1="homeassistant.internal.mollner.cloud"
export CERT_DOMAIN_2="assistant.internal.mollner.cloud"
export ENV_FILE="${CONF_FOLDER}/env_files/homeassistant.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN_1" --domain "$CERT_DOMAIN_2" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"

# homebridge
export CERT_DOMAIN="homebridge.internal.mollner.cloud"
export ENV_FILE="${CONF_FOLDER}/env_files/homebridge.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"

# n8n
export CERT_DOMAIN="n8n.internal.mollner.cloud"
export ENV_FILE="${CONF_FOLDER}/env_files/n8n.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"

# node-red
export CERT_DOMAIN="node-red.internal.mollner.cloud"
export ENV_FILE="${CONF_FOLDER}/env_files/node-red.env"
# bash scripts/acme_run.sh --issue --domain "$CERT_DOMAIN" --dns "$CERT_DNS" --server "${ACME_DIRECTORY_RESOURCE}"
