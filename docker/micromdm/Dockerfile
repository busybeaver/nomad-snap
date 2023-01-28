# syntax=docker/dockerfile:1
FROM ghcr.io/micromdm/micromdm:v1.10.1@sha256:0bc44d165528d12ba5dce74054b18357fe899a0b3d8025459d24420716b266e8

# Enabling the docker healthcheck below
ENV MICROMDM_HTTP_HOMEPAGE=true

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://127.0.0.1:8080 || exit 1

# renovate: datasource=repology depName=alpine_3_15/libcap versioning=loose
ARG LIBCAP_VERSION="2.61-r0"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run micromdm on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache upgrade && \
    apk --update-cache --no-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/micromdm
