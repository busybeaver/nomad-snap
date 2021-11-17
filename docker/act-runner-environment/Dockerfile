# A Debian based minimal Node.js with Python installed; mostly used for running the GitHub Action CI locally via "act";
# Tries to mimic the runtime environment of GitHub Actions while being as minimal as possible
FROM node:slim

RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get install python-is-python2=2.\* --no-install-recommends --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
