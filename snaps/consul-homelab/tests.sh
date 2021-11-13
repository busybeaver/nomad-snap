#!/bin/bash
set -x

snap list --color=never consul-homelab
echo '-----------------'
snap info --color=never consul-homelab
echo '-----------------'
consul-homelab version
echo '-----------------'
snap services consul-homelab
echo '-----------------'
consul-homelab agent -dev &
sleep 10s
echo '-----------------'
snap services consul-homelab
echo '-----------------'
consul-homelab members
echo '-----------------'
curl localhost:8500/v1/catalog/nodes
echo '-----------------'
consul-homelab kv put foo/bar 1
consul-homelab kv get foo/bar
echo '-----------------'
consul-homelab leave
