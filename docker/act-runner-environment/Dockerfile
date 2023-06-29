# syntax=docker/dockerfile:1

# A Debian based minimal Node.js environment with Python installed; mostly used for running the GitHub Action CI
# locally via "act"; tries to mimic the runtime environment of GitHub Actions while being as minimal as possible
FROM node:lts-bullseye-slim@sha256:c3d9537001905b8a7cf494ee0f7096590a2bf20957686879a95fd79adb9a7816

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
