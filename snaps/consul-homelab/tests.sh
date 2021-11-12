#!/bin/bash

snap list --color=never consul-homelab
echo '-----------------'
snap info --color=never consul-homelab
echo '-----------------'
consul-homelab version
