# syntax=docker/dockerfile:1@sha256:a57df69d0ea827fb7266491f2813635de6f17269be881f696fbfdf2d83dda33e
FROM caddy:2.8.1-builder-alpine@sha256:9b0e5fefc8876b84dc74dd15b7413da6ad26b0642a4fb11d8f37399ad47fa572 AS build

RUN --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.8.1-alpine@sha256:54b067d60ae306670ab09f10b6f309f19e4e0f43927ae514d3740fbe7964872f

COPY --from=build /usr/bin/caddy /usr/bin/caddy

# check here on which alpine version caddy is based on and update the renovate config when needed:
# https://github.com/caddyserver/caddy-docker
# https://repology.org/project/libcap/versions
# ---
# renovate: datasource=repology depName=alpine_3_20/libcap versioning=loose
ARG LIBCAP_VERSION="2.70-r0"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run Caddy on privileged ports (as a non-root user)
RUN --mount=type=cache,id=apk,sharing=locked,target=/var/cache/apk \
    apk --update-cache upgrade && \
    apk --update-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
