# a HomeAssistant version that can be run as non-root user

FROM alpine/git:v2.34.1@sha256:b03f9259403bbf8dd365bb90ef2b7286b89f1d1c594f6d5bc3a0a49199a82359 as build

ENV GIT_TAG_VERSION="v2.3"
WORKDIR /tmp/homeassistant-docker-venv
RUN git clone --depth 1 --branch ${GIT_TAG_VERSION} https://github.com/tribut/homeassistant-docker-venv.git .

FROM homeassistant/home-assistant:2022.4@sha256:df33991a7a9af760e67173e4146525e9fc6cf47f3768ea44c5548af44b862ede

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://127.0.0.1:8123 || exit 1

ENV HOME_ASSISTANT_ENTRYPOINT="/etc/services.d/home-assistant/run"
# this is a simple build time check to ensure that the home assistant
# entry point didn't change in the base/parent image. without this
# check, a changed entry point would only be detected "later" during
# runtime (which is obviously not desirable)
RUN cat ${HOME_ASSISTANT_ENTRYPOINT} > /dev/null
# copy/override the entry point of home-assistant
COPY --from=build /tmp/homeassistant-docker-venv/run ${HOME_ASSISTANT_ENTRYPOINT}
# update linux base packages (to fix potential security issues)
RUN apk update --no-cache && apk upgrade --no-cache
