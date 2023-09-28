cd /volume1/homes/busybeaver42/homelab-packages/

# general setup
CONF_FOLDER="/volume1/homes/busybeaver42/homelab-packages-config"
export ACME_HOME="${CONF_FOLDER}/acme.sh"

# refresh all certificates
bash scripts/acme_run.sh --cron --insecure
