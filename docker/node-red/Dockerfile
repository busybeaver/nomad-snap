# syntax=docker/dockerfile:1@sha256:a57df69d0ea827fb7266491f2813635de6f17269be881f696fbfdf2d83dda33e
FROM nodered/node-red:3.1.9-18-minimal

ARG NPM_CACHE_FOLDER="/usr/src/node-red/npm_cache"

# renovate: datasource=npm depName=node-red-contrib-homekit-bridged versioning=npm
ARG NODE_RED_HOMEKIT_BRIDGED_VERSION=1.6.1
# renovate: datasource=npm depName=node-red-contrib-huemagic versioning=npm
ARG NODE_RED_HUEMAGIC_VERSION=4.2.2
# renovate: datasource=npm depName=node-red-node-pushover versioning=npm
ARG NODE_RED_PUSHOVER_VERSION=0.2.1
# renovate: datasource=npm depName=node-red-contrib-knx-ultimate versioning=npm
ARG NODE_RED_KNX_ULTIMATE_VERSION=2.5.1
# renovate: datasource=npm depName=node-red-contrib-sonos-plus versioning=npm
ARG NODE_RED_SONOS_PLUS_VERSION=6.9.0
# renovate: datasource=npm depName=node-red-contrib-sonos-event versioning=npm
ARG NODE_RED_SONOS_EVENTS_VERSION=1.2.4
# renovate: datasource=npm depName=node-red-contrib-dwd-local-weather versioning=npm
ARG NODE_RED_DWD_LOCAL_WEATHER_VERSION=1.0.5

RUN --mount=type=cache,id=npm,sharing=locked,uid=1000,gid=1000,target="${NPM_CACHE_FOLDER}" \
    npm_config_cache="${NPM_CACHE_FOLDER}" npm install --no-fund --no-package-lock --save-prod --save-exact \
    node-red-contrib-homekit-bridged@${NODE_RED_HOMEKIT_BRIDGED_VERSION} \
    node-red-contrib-huemagic@${NODE_RED_HUEMAGIC_VERSION} \
    node-red-node-pushover@${NODE_RED_PUSHOVER_VERSION} \
    node-red-contrib-knx-ultimate@${NODE_RED_KNX_ULTIMATE_VERSION} \
    node-red-contrib-sonos-plus@${NODE_RED_SONOS_PLUS_VERSION} \
    node-red-contrib-sonos-events@${NODE_RED_SONOS_EVENTS_VERSION} \
    node-red-contrib-dwd-local-weather@${NODE_RED_DWD_LOCAL_WEATHER_VERSION}

# Update outdated (and potentially vulnerable) dependencies
USER root
RUN --mount=type=cache,id=apk,sharing=locked,target=/var/cache/apk \
    apk --update-cache upgrade
USER node-red
