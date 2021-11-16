# a HomeAssistant version that can be run as non-root user

FROM alpine/git:v2.32.0@sha256:89c47ab2b42fff8100f67b88d175bd3a3cf2bf1ae261aedb7eb2d4239f203e93 as build

ENV GIT_TAG_VERSION="v2.3"
WORKDIR /tmp/homeassistant-docker-venv
RUN git clone --depth 1 --branch ${GIT_TAG_VERSION} https://github.com/tribut/homeassistant-docker-venv.git .

FROM homeassistant/home-assistant:2021.11@sha256:2d4f23e8e355f3daa2a836c1a09dc9f001e04dd4dea8f8dec71ff9f10bc269cc

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
