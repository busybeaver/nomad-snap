# syntax=docker/dockerfile:1
FROM ghcr.io/micromdm/micromdm:v1.9.0@sha256:873786ad722f1596cfc421deec7ff4f7bc5de70258df0573d17e09d13adc4a79

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
