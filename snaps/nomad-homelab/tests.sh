#!/bin/bash

snap list --color=never nomad-homelab
echo '-----------------'
snap info --color=never nomad-homelab
echo '-----------------'
nomad-homelab version
