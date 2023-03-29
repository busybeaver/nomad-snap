# syntax=docker/dockerfile:1
FROM caddy:2.6.4-builder-alpine@sha256:db0bf3ad3803a9ba3e2e4bf6d26323e3dd20d9a4c294aaf32dccc5bbd1896cee AS build

RUN --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.6.4-alpine@sha256:120c1f2779e246261755d5763b0dedb009b2ca965a34fb6fcc8665da4f3a4bbe

COPY --from=build /usr/bin/caddy /usr/bin/caddy

# check here on which alpine version caddy is based on and update the renovate config when needed:
# https://github.com/caddyserver/caddy-docker
# ---
# renovate: datasource=repology depName=alpine_3_16/libcap versioning=loose
ARG LIBCAP_VERSION="2.64-r0"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run Caddy on privileged ports (as a non-root user)
RUN --mount=type=cache,id=apk,sharing=locked,target=/var/cache/apk \
    apk --update-cache upgrade && \
    apk --update-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
