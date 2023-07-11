# syntax=docker/dockerfile:1
FROM caddy:2.6.4-builder-alpine@sha256:19c33a725e762ef6fd3bd27d4737f0abfe22d95c278c3a51cc463d688088bdd1 AS build

RUN --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.6.4-alpine@sha256:993f27cb24190f8b714f6ffd0cd487281b48b64a70d6575be8eee18b6c2b02af

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
