#!/bin/bash
set -x

docker-compose down
cat /goss/docker_output.log
