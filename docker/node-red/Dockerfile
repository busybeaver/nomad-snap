# syntax=docker/dockerfile:1@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021
FROM nodered/node-red:3.1.7-16-minimal@sha256:d82e483073ca085f19b118bef27afa482fce03b1a17100bbc07de5a266ff6147

ARG NPM_CACHE_FOLDER="/usr/src/node-red/npm_cache"

# renovate: datasource=npm depName=node-red-contrib-homekit-bridged versioning=npm
ARG NODE_RED_HOMEKIT_BRIDGED_VERSION=1.6.1
# renovate: datasource=npm depName=node-red-contrib-huemagic versioning=npm
ARG NODE_RED_HUEMAGIC_VERSION=4.2.2
# renovate: datasource=npm depName=node-red-node-pushover versioning=npm
ARG NODE_RED_PUSHOVER_VERSION=0.2.1
# renovate: datasource=npm depName=node-red-contrib-knx-ultimate versioning=npm
ARG NODE_RED_KNX_ULTIMATE_VERSION=2.4.6

RUN --mount=type=cache,id=npm,sharing=locked,uid=1000,gid=1000,target="${NPM_CACHE_FOLDER}" \
    npm_config_cache="${NPM_CACHE_FOLDER}" npm install --no-fund --no-package-lock --save-prod --save-exact \
    node-red-contrib-homekit-bridged@${NODE_RED_HOMEKIT_BRIDGED_VERSION} \
    node-red-contrib-huemagic@${NODE_RED_HUEMAGIC_VERSION} \
    node-red-node-pushover@${NODE_RED_PUSHOVER_VERSION} \
    node-red-contrib-knx-ultimate@${NODE_RED_KNX_ULTIMATE_VERSION}

# Update outdated (and potentially vulnerable) dependencies
USER root
RUN --mount=type=cache,id=apk,sharing=locked,target=/var/cache/apk \
    apk --update-cache upgrade
USER node-red
