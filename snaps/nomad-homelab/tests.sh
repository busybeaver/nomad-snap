#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

set -x

snap list --color=never nomad-homelab
echo '-----------------'
snap info --color=never nomad-homelab
echo '-----------------'
nomad-homelab version
echo '-----------------'
