FROM ghcr.io/micromdm/micromdm:v1.9.0

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://127.0.0.1:80 || exit 1

# to enable the docker healthcheck above
ENV MICROMDM_HTTP_HOMEPAGE=true

# Allow to run micromdm on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache add libcap=~2.61 && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/micromdm
