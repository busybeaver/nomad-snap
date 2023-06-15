# syntax=docker/dockerfile:1
FROM caddy:2.6.4-builder-alpine@sha256:bb3ec9a5d2f61c3a30a206b52b639983325498ba2d5223eafa111823e7b91f0c AS build

RUN --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.6.4-alpine@sha256:ca93629e04db8047dd93aa2bf1e66d24230146e83fc20034f5c210a895fd2f02

COPY --from=build /usr/bin/caddy /usr/bin/caddy

# check here on which alpine version caddy is based on and update the renovate config when needed:
# https://github.com/caddyserver/caddy-docker
# ---
# renovate: datasource=repology depName=alpine_3_16/libcap versioning=loose
ARG LIBCAP_VERSION="2.64-r1"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run Caddy on privileged ports (as a non-root user)
RUN --mount=type=cache,id=apk,sharing=locked,target=/var/cache/apk \
    apk --update-cache upgrade && \
    apk --update-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
