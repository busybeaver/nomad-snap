#!/bin/bash
set -x

# this is strictly necessary to stop the service since we shut down the instance afterwards anyways;
# it's more of a check that the service shutdown works fine
sudo snap stop "${SERVICE_NAME}.daemon"
sleep 10s
sudo snap logs "${SERVICE_NAME}"
