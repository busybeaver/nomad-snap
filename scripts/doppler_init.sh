#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

# renovate: datasource=github-releases depName=DopplerHQ/cli versioning=loose
DOPPLER_VERSION="3.66.5"

DOPPLER_TEMP_INSTALL_DIRECTORY="/tmp/doppler-install"

mkdir "${DOPPLER_TEMP_INSTALL_DIRECTORY}"
cd "${DOPPLER_TEMP_INSTALL_DIRECTORY}"
curl -Ls --proto "=https" --tlsv1.3 --retry 3 "https://github.com/DopplerHQ/cli/releases/download/${DOPPLER_VERSION}/doppler_${DOPPLER_VERSION}_linux_amd64.tar.gz" > doppler_linux_arm64.tar.gz
tar -xvzf doppler_linux_arm64.tar.gz

chmod +x "${DOPPLER_TEMP_INSTALL_DIRECTORY}/doppler"
sudo mv "${DOPPLER_TEMP_INSTALL_DIRECTORY}/doppler" /usr/local/bin/doppler

rm -rf "${DOPPLER_TEMP_INSTALL_DIRECTORY}"
