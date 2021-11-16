#!/bin/bash
set -x

snap list --color=never consul-homelab
echo '-----------------'
snap info --color=never consul-homelab
echo '-----------------'
consul-homelab version
echo '-----------------'
sudo snap services consul-homelab
echo '-----------------'
sudo snap start consul-homelab.daemon
sleep 10s
echo '-----------------'
sudo snap logs consul-homelab
echo '-----------------'
snap services consul-homelab
echo '-----------------'
sudo consul-homelab members
echo '-----------------'
curl localhost:8500/v1/catalog/nodes
echo '-----------------'
consul-homelab kv put foo/bar 1
consul-homelab kv get foo/bar
echo '-----------------'
sudo snap stop consul-homelab.daemon
