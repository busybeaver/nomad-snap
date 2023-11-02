# syntax=docker/dockerfile:1
FROM caddy:2.7.5-builder-alpine@sha256:1e3541241be6bbc028448f400f5e4d4ae4ff3e2a45b585e6502868cbe8b74146 AS build

RUN --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.7.5-alpine@sha256:f1c092da9fcba7a8197cf1065a347d4f0bb67b6dd188985eafaf0a5aec6c9041

COPY --from=build /usr/bin/caddy /usr/bin/caddy

# check here on which alpine version caddy is based on and update the renovate config when needed:
# https://github.com/caddyserver/caddy-docker
# https://repology.org/project/libcap/versions
# ---
# renovate: datasource=repology depName=alpine_3_18/libcap versioning=loose
ARG LIBCAP_VERSION="2.69-r0"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run Caddy on privileged ports (as a non-root user)
RUN --mount=type=cache,id=apk,sharing=locked,target=/var/cache/apk \
    apk --update-cache upgrade && \
    apk --update-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
