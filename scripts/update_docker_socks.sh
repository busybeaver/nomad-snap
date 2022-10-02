#! /bin/bash
set -x

# change group of the docker.sock, so selected users can access/use it properly and without user elevation
chgrp docker-sock-users /var/run/docker.sock
