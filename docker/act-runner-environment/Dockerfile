# A Debian based minimal Node.js with Python installed; mostly used for running the GitHub Action CI locally via "act";
# Tries to mimic the runtime environment of GitHub Actions while being as minimal as possible
FROM node:slim@sha256:abbec24c04a3b7519c28de3aa5b65b52ba8d3f5e8acdf824564bf168efb65b39

RUN apt-get update && \
    apt-get install python-is-python2=2.\* --no-install-recommends --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
