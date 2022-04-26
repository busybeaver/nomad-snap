FROM node:lts-bullseye-slim@sha256:d54981fe891c9e3442ea05cb668bc8a2a3ee38609ecce52c7b5a609fadc6f64b as build

COPY package.json package-json.lock /tmp/
WORKDIR /tmp/
RUN npm install --no-fund --production

FROM nodered/node-red:2.2.2-16-minimal

ARG node_red_modules_folder="/usr/src/node-red-modules/node_modules"

COPY --from=build --chown=node-red /tmp/node_modules/ ${node_red_modules_folder}/
ENV NODE_PATH "$NODE_PATH:${node_red_modules_folder}"
