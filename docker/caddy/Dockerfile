# syntax=docker/dockerfile:1@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021
FROM caddy:2.7.6-builder-alpine@sha256:6830ac674c20121639507269dc8c2fe4283de1be46818111db409812d10d5de1 AS build

RUN --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/lolPants/caddy-requestid \
    --with github.com/hslatman/caddy-crowdsec-bouncer \
    --with github.com/caddyserver/transform-encoder

FROM caddy:2.7.6-alpine@sha256:a9044fcee0bb19da784385461997d320fb05f59a8388fb76cfbb99e8f527c643

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
