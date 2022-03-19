#!/bin/bash
set -x

cd "/var/snap/${SERVICE_NAME}/current/" || exit 1
sudo mkdir config data

echo "
#bind_addr = \"{{ GetInterfaceIP \\\"eth0\\\" }}\"
bind_addr = \"0.0.0.0\"
data_dir = \"/var/snap/${SERVICE_NAME}/current/data\"
log_level = \"INFO\"
datacenter = \"github_actions\"
node_name = \"runner\"
server = true
bootstrap = true
" | sudo tee ./config/test.hcl

sudo snap connections "${SERVICE_NAME}"

sudo snap start "${SERVICE_NAME}.daemon"
sleep 10s
