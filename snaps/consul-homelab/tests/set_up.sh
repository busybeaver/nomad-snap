#!/bin/bash
set -x

mkdir -p "/var/snap/${SERVICE_NAME}/current/config"
echo "{\"dev\": true}" > "/var/snap/${SERVICE_NAME}/current/config/test.json"
