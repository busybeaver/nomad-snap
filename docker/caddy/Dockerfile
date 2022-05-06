# syntax=docker/dockerfile:1
FROM caddy:2.5.1-builder-alpine@sha256:ff23b013ade33406dd2e60779e6280de163784e000058c99bcfdb1f914238103 AS build

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.5.1-alpine@sha256:8325b6e8188895a1c971e1e5f629d01eb65c1c075f5efce6f016766dfb92b26e

COPY --from=build /usr/bin/caddy /usr/bin/caddy

# renovate: datasource=repology depName=alpine_3_15/libcap versioning=loose
ARG LIBCAP_VERSION="2.61-r0"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run Caddy on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache upgrade && \
    apk --update-cache --no-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
