# syntax=docker/dockerfile:1@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021
FROM ghcr.io/micromdm/micromdm:v1.12.1@sha256:4854deb1a413bffdb81616af1ae14316185dcab51b88c421f0516d8541596bee

# Enabling the docker healthcheck below
ENV MICROMDM_HTTP_HOMEPAGE=true

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://127.0.0.1:8080 || exit 1

# renovate: datasource=repology depName=alpine_3_19/libcap versioning=loose
ARG LIBCAP_VERSION="2.69-r1"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run micromdm on privileged ports (as a non-root user)
RUN --mount=type=cache,id=apk,sharing=locked,target=/var/cache/apk \
    apk --update-cache upgrade && \
    apk --update-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/micromdm
