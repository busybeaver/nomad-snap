# A Debian based minimal Node.js environment with Python installed; mostly used for running the GitHub Action CI
# locally via "act"; tries to mimic the runtime environment of GitHub Actions while being as minimal as possible
FROM node:slim@sha256:05669526d5e628193fe7e20540a45ff1929414e8c2e713454eee39f717521636

LABEL org.opencontainers.image.title="A minimal act runner environment with Python 3 installed" \
      org.opencontainers.image.description="A Debian based minimal Node.js environment with Python installed; mostly used for running the GitHub Action CI locally via \"act\"; tries to mimic the runtime environment of GitHub Actions while being as minimal as possible" \
      org.opencontainers.image.base.name="node:slim" \
      org.opencontainers.image.authors="busybeaver" \
      org.opencontainers.image.source="https://github.com/busybeaver/homelab-packages"

RUN apt-get update && \
    apt-get upgrade --no-install-recommends --yes && \
    apt-get install python3-minimal=3.\* --no-install-recommends --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
