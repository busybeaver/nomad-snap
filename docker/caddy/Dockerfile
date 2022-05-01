# syntax=docker/dockerfile:1.4
FROM caddy:2.5.0-builder-alpine@sha256:2cf9717916c3411cda2bfd15db21f1f40b43626eac201327da49ce01d40628dd AS build

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.5.0-alpine@sha256:e602ecd5eed4cae0d809ef6cdd2b0faa091da3cea6f71dbfdfa924411c744b99

COPY --from=build /usr/bin/caddy /usr/bin/caddy

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run Caddy on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache upgrade && \
    apk --update-cache --no-cache add libcap=~2.61 && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
