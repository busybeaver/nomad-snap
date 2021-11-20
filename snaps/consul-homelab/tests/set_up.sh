#!/bin/bash
set -x

sudo mkdir -p "/var/snap/${SERVICE_NAME}/current/config"
sudo echo "{\"dev\": true}" > "/var/snap/${SERVICE_NAME}/current/config/test.json"
