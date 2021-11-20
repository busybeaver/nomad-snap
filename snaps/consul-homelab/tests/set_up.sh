#!/bin/bash
set -x

sudo mkdir -p "/var/snap/${SERVICE_NAME}/current/config"
echo 'bind_addr = "{{ GetInterfaceIP \"eth0\" }}"' | sudo tee "/var/snap/${SERVICE_NAME}/current/config/test.hcl"
