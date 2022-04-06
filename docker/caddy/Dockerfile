# syntax=docker/dockerfile:1.4
FROM caddy:2.4.6-builder-alpine@sha256:54e2deab0aa5245b222cba916d21cb85acb53793dbb1651e3c7a6e7eb6240089 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.4.6-alpine@sha256:15e576e7d00b1f41a648c5295a03677c24da5fede09131edcb1e6d809c7dc8aa

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Allow to run Caddy on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache add libcap=~2.50 && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
