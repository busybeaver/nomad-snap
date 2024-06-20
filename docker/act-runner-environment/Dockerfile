# syntax=docker/dockerfile:1@sha256:e87caa74dcb7d46cd820352bfea12591f3dba3ddc4285e19c7dcd13359f7cefd

# A Debian based minimal Node.js environment with Python installed; mostly used for running the GitHub Action CI
# locally via "act"; tries to mimic the runtime environment of GitHub Actions while being as minimal as possible
FROM node:lts-bullseye-slim@sha256:8b9e42d429c49b537b8d06f75aa261a2327d62362336d570f5d3b1a669e33589

LABEL org.opencontainers.image.title="A minimal act runner environment with Python 3 installed" \
      org.opencontainers.image.description="A Debian based minimal Node.js environment with Python installed; mostly used for running the GitHub Action CI locally via \"act\"; tries to mimic the runtime environment of GitHub Actions while being as minimal as possible" \
      org.opencontainers.image.base.name="lts-bullseye-slim" \
      org.opencontainers.image.authors="busybeaver" \
      org.opencontainers.image.source="https://github.com/busybeaver/homelab-packages"

# Update outdated (and potentially vulnerable) dependencies;
# Install python3 which is used to in the CI flows to set up the build matrix
RUN --mount=type=cache,id=apt_lists,sharing=locked,target=/var/lib/apt/lists \
    --mount=type=cache,id=apt,sharing=locked,target=/var/cache/apt \
    apt-get update && \
    apt-get upgrade --no-install-recommends --yes && \
    apt-get install python3-minimal=3.\* --no-install-recommends --yes
