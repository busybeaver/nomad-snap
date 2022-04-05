# syntax=docker/dockerfile:1.4
FROM caddy:2.4.6-builder-alpine@sha256:ad4f404a64f4f6c80d3911ab6b3a7c3edf78fcc06f0c59352e98bd739ba855a7 AS builder

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
