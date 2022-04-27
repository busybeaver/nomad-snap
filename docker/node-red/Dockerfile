FROM node:lts-bullseye-slim@sha256:d54981fe891c9e3442ea05cb668bc8a2a3ee38609ecce52c7b5a609fadc6f64b as build

# preinstalling modules/packages improves the immutability and reproducability of the service;
# for improved security, installing additional modules/packages during runtime can then be disabled:
# https://nodered.org/docs/user-guide/runtime/configuration#runtime-configuration (see the "externalModules" option)
COPY package.json package-lock.json /tmp/
WORKDIR /tmp/
RUN npm install --no-fund --production

FROM nodered/node-red:2.2.2-16-minimal

ARG node_red_modules_folder="/usr/src/node-red-modules/node_modules"

COPY --from=build --chown=node-red /tmp/node_modules/ ${node_red_modules_folder}/
ENV NODE_PATH "$NODE_PATH:${node_red_modules_folder}"
