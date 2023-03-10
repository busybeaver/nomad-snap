# syntax=docker/dockerfile:1
FROM caddy:2.6.4-builder-alpine@sha256:efaac7e3182771d9b8f67af7b275c649d7590d87e6339f35a1f747181d2fc9d5 AS build

RUN --mount=type=cache,target=/root/.cache/go-build \
    pwd && id && xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.6.4-alpine@sha256:3f4414616d9141c4fbd9f66641d9b91a3b67833dd4145738c536dee584db5314

COPY --from=build --link=true /usr/bin/caddy /usr/bin/caddy

# check here on which alpine version caddy is based on and update the renovate config when needed:
# https://github.com/caddyserver/caddy-docker
# ---
# renovate: datasource=repology depName=alpine_3_16/libcap versioning=loose
ARG LIBCAP_VERSION="2.64-r0"

# Update outdated (and potentially vulnerable) dependencies;
# Allow to run Caddy on privileged ports (as a non-root user)
RUN --mount=type=cache,id=apk,sharing=locked,target=/var/cache/apk \
    apk --update-cache upgrade && \
    apk --update-cache add libcap=${LIBCAP_VERSION} && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
