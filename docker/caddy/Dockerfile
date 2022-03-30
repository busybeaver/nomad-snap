# syntax=docker/dockerfile:1.4
FROM caddy:builder-alpine@sha256:47fbe5354ee0e56faaab47d85cd0e212914290367b7815eaea9175387a081145 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer

FROM caddy:alpine@sha256:dd418a7216b6f833804da6b82fb215b7659f22ba7dd0196e201b2266dc2fd095

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Allow to run Caddy on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache add libcap=~2.50 && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
