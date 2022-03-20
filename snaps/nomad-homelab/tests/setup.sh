#!/bin/bash
set -x

cd "/var/snap/${SERVICE_NAME}/current/" || exit 1
sudo mkdir config data

echo "
bind_addr = \"{{ GetInterfaceIP \\\"eth0\\\" }}\"
#bind_addr = \"0.0.0.0\"
data_dir  = \"/var/snap/${SERVICE_NAME}/current/data\"
log_level = \"INFO\"
datacenter = \"github_actions\"
name = \"runner\"
# it's not recommended to operate a node as both client and server, although this is supported to simplify development and testing.
server {
  enabled = true
  # a value of 1 does not provide any fault tolerance and is not recommended for production use cases.
  bootstrap_expect = 1
}
client {
  enabled = true
  servers = [\"127.0.0.1\"]
}
" | sudo tee ./config/test.hcl

sudo snap connect "${SERVICE_NAME}:mount-observe" ":mount-observe"
sudo snap connect "${SERVICE_NAME}:network-observe" ":network-observe"
# TODO: add docker plug/connection

sudo snap connections "${SERVICE_NAME}"
sudo snap start "${SERVICE_NAME}.daemon"
sleep 10s

sudo snap logs "${SERVICE_NAME}"
