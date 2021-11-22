#!/bin/bash
set -x

sudo mkdir -p /var/snap/"${SERVICE_NAME}"/current/{config,data}/
ls -la "/var/snap/${SERVICE_NAME}/current/"
echo "
bind_addr = \"{{ GetInterfaceIP \\\"eth0\\\" }}\"
data_dir = \"/var/snap/${SERVICE_NAME}/current/data\"
log_level = \"INFO\"
datacenter = \"github_actions\"
node_name = \"runner\"
server = true
bootstrap = true
" | sudo tee /var/snap/"${SERVICE_NAME}"/current/config/test.hcl
sudo snap start "${SERVICE_NAME}".daemon
sleep 10s
