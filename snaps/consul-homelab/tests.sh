#!/bin/bash

snap list --color=never consul-homelab
echo '-----------------'
snap info --color=never consul-homelab
echo '-----------------'
echo '-----------------'
consul-homelab version
echo '-----------------'
sudo consul-homelab agent -dev &
sleep 10s
consul-homelab members
echo '-----------------'
curl localhost:8500/v1/catalog/nodes
echo '-----------------'
consul-homelab kv put foo/bar 1
consul-homelab kv get foo/bar
echo '-----------------'
consul-homelab leave
