# syntax=docker/dockerfile:1.4
FROM caddy:2.4.6-builder-alpine@sha256:42c77e260a81ac7624cb15980cc11615abb48d477b9036ac24a4571d8b38f789 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.4.6-alpine@sha256:dd418a7216b6f833804da6b82fb215b7659f22ba7dd0196e201b2266dc2fd095

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Allow to run Caddy on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache add libcap=~2.50 && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
