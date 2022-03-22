# a HomeAssistant version that can be run as non-root user

FROM alpine/git:v2.32.0@sha256:a8a31155488a93a4d8abb834777c7b5f9d7c93db6051defbad8cc066b4e90072 as build

ENV GIT_TAG_VERSION="v2.3"
WORKDIR /tmp/homeassistant-docker-venv
RUN git clone --depth 1 --branch ${GIT_TAG_VERSION} https://github.com/tribut/homeassistant-docker-venv.git .

FROM homeassistant/home-assistant:2022.3@sha256:3222cc7275138a64af069fdcaa780c4de2558f5778fd54fc64ac13c102895c3a

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
