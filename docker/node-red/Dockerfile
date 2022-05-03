# syntax=docker/dockerfile:1
FROM nodered/node-red:2.2.2-16-minimal@sha256:80d8994f7ae471ec68752d6e28955648427b88e904086089c771e0f715402fa4

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
