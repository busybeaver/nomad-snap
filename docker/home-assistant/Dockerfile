# a HomeAssistant version that can be run as non-root user

FROM alpine/git:v2.32.0@sha256:89c47ab2b42fff8100f67b88d175bd3a3cf2bf1ae261aedb7eb2d4239f203e93 as build

ENV TAG_VERSION="v2.3"

WORKDIR /tmp/homeassistant-docker-venv
RUN git clone --depth 1 --branch ${TAG_VERSION} https://github.com/tribut/homeassistant-docker-venv.git .

FROM homeassistant/home-assistant:2021.11@sha256:5ce17ccd2271d05afd07780e92b494b5cdf197618d5404bf9b86d9cd670e5b90

ENV HOME_ASSISTANT_ENTRYPOINT="/etc/services.d/home-assistant/run"

# this is a simple build time check to ensure that the home assistant
# entry point didn't change in the base/parent image. without this
# check, a changed entry point would only be detected "later" during
# runtime (which is obviously not desirable)
RUN cat ${HOME_ASSISTANT_ENTRYPOINT} > /dev/null

COPY --from=build /tmp/homeassistant-docker-venv/run ${HOME_ASSISTANT_ENTRYPOINT}
