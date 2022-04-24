FROM ghcr.io/micromdm/micromdm:v1.9.0@sha256:873786ad722f1596cfc421deec7ff4f7bc5de70258df0573d17e09d13adc4a79

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://127.0.0.1:80 || exit 1

# to enable the docker healthcheck above
ENV MICROMDM_HTTP_HOMEPAGE=true

# Allow to run micromdm on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache add libcap=~2.61 && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/micromdm
