# a HomeAssistant version that can be run as non-root user

FROM alpine/git:v2.34.2@sha256:dd88601a5889009b3852cf6748e2d23a0dd17ef6e26864d74f2cca24bfc4159f as build

ENV GIT_TAG_VERSION="v2.3"
WORKDIR /tmp/homeassistant-docker-venv
RUN git clone --depth 1 --branch ${GIT_TAG_VERSION} https://github.com/tribut/homeassistant-docker-venv.git .

FROM homeassistant/home-assistant:2022.4@sha256:72e1c45e367cd83845f2a3e29f42a3ab158765ee3f48d9f9b4b8dbd5b71009bd

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://127.0.0.1:8123 || exit 1

ENV HOME_ASSISTANT_ENTRYPOINT="/etc/services.d/home-assistant/run"

# This is a simple build time check to ensure that the home assistant
# entry point didn't change in the base/parent image. without this
# check, a changed entry point would only be detected "later" during
# runtime (which is obviously not desirable)
RUN cat ${HOME_ASSISTANT_ENTRYPOINT} > /dev/null

# Copy/override the entry point of home-assistant
COPY --from=build /tmp/homeassistant-docker-venv/run ${HOME_ASSISTANT_ENTRYPOINT}

# Update outdated (and potentially vulnerable) dependencies
RUN apk --update-cache --no-cache upgrade
