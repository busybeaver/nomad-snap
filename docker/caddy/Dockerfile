# syntax=docker/dockerfile:1
FROM caddy:2.6.4-builder-alpine@sha256:6a6200d6f94d3e2f715b2066b22dbcb49e9598feab6c86bbb40cde3200644a76 AS build

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.6.4-alpine@sha256:5c484a4a330983be3377bc7f78ec04e168e1cc48ad1ece215e301a47672471f7

COPY --from=build /usr/bin/caddy /usr/bin/caddy

# check here on which alpine version caddy is based on and update the renovate config when needed:
# https://github.com/caddyserver/caddy-docker
# ---
# renovate: datasource=repology depName=alpine_3_16/libcap versioning=loose
ARG LIBCAP_VERSION="2.64-r0"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run Caddy on privileged ports (as a non-root user)
RUN apk --update-cache --no-cache upgrade && \
    apk --update-cache --no-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
