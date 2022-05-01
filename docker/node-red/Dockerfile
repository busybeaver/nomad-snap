FROM nodered/node-red:2.2.2-16-minimal@sha256:80d8994f7ae471ec68752d6e28955648427b88e904086089c771e0f715402fa4 as build

# preinstalling modules/packages improves the immutability and reproducability of the service;
# for improved security, installing additional modules/packages during runtime can then be disabled:
# https://nodered.org/docs/user-guide/runtime/configuration#runtime-configuration (see the "externalModules" option)

USER root
RUN apk --update-cache --no-cache add jq=~1.6
USER node-red

COPY package.json /usr/src/node-red/package-addon.json
# merge dependencies property of to package.json files and use it in the package.json file
RUN jq ".dependencies = $(jq ".dependencies + $(jq -c '.dependencies' package.json)" package-addon.json)" package.json > package_tmp.json && \
    mv package_tmp.json package.json && \
    rm ./package-addon.json && \
    npm install --no-fund --no-package-lock --production

FROM nodered/node-red:2.2.2-16-minimal@sha256:80d8994f7ae471ec68752d6e28955648427b88e904086089c771e0f715402fa4

COPY --from=build --chown=node-red /usr/src/node-red/package.json /usr/src/node-red/package.json
COPY --from=build --chown=node-red /usr/src/node-red/node_modules/ /usr/src/node-red/node_modules/

# update outdated (and vulnerable) dependencies
USER root
RUN apk --update-cache --no-cache upgrade
USER node-red
