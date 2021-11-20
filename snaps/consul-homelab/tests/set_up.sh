#!/bin/bash
set -x

sudo mkdir -p "/var/snap/${SERVICE_NAME}/current/config/data"
echo "
bind_addr = \"{{ GetInterfaceIP \\\"eth0\\\" }}\"
data_dir = \"/var/snap/${SERVICE_NAME}/current/config/data\"
log_level = \"INFO\"
datacenter = \"github_actions\"
node_name = \"runner\"
server = true
bootstrap = true
" | sudo tee "/var/snap/${SERVICE_NAME}/current/config/test.hcl"
sudo snap start "${SERVICE_NAME}.daemon"
sleep 10s

# temp
echo "-------"
consul-homelab version
echo "-------"
sudo snap logs consul-homelab
echo "-------"
consul-homelab members
echo "-------"
consul-homelab kv put foo/bar 1
echo "-------"
curl -v http://localhost:8500/v1/catalog/nodes
echo "-------"
