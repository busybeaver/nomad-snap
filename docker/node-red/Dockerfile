# syntax=docker/dockerfile:1
FROM nodered/node-red:3.0.0-16-minimal@sha256:fdc8fdce28d7ff5a680bc3c1094f14128bfeae3207fb82795002a965a47eb34c

# renovate: datasource=npm depName=node-red-contrib-homekit-bridged versioning=npm
ARG NODE_RED_HOMEKIT_BRIDGED_VERSION=1.4.3
# renovate: datasource=npm depName=node-red-contrib-huemagic versioning=npm
ARG NODE_RED_HUEMAGIC_VERSION=4.2.2
# renovate: datasource=npm depName=node-red-node-pushover versioning=npm
ARG NODE_RED_PUSHOVER_VERSION=0.1.1

RUN npm install --no-fund --no-package-lock --save-prod --save-exact \
    node-red-contrib-homekit-bridged@${NODE_RED_HOMEKIT_BRIDGED_VERSION} \
    node-red-contrib-huemagic@${NODE_RED_HUEMAGIC_VERSION} \
    node-red-node-pushover@${NODE_RED_PUSHOVER_VERSION}

# Update outdated (and potentially vulnerable) dependencies
USER root
RUN apk --update-cache --no-cache upgrade
USER node-red
