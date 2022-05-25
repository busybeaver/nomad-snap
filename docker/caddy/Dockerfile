# syntax=docker/dockerfile:1
FROM caddy:2.5.1-builder-alpine@sha256:85fe2f4769adb654e2bdf1fa9a1c9837370c9e50cf13337f320309cd7a727b1d AS build

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.5.1-alpine@sha256:0033b34d2df3fe0bf94088c36e7d722ceca1b38cbdd49c08b2c10b9f9aa58912

COPY --from=build /usr/bin/caddy /usr/bin/caddy

# renovate: datasource=repology depName=alpine_3_15/libcap versioning=loose
ARG LIBCAP_VERSION="2.61-r0"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run Caddy on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache upgrade && \
    apk --update-cache --no-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
