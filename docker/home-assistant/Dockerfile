# a HomeAssistant version that can be run as non-root user

FROM alpine/git:v2.32.0@sha256:192d7b402bfd313757d5316920fea98606761e96202d850e5bdeab407b9a72ae as build

ENV GIT_TAG_VERSION="v2.3"
WORKDIR /tmp/homeassistant-docker-venv
RUN git clone --depth 1 --branch ${GIT_TAG_VERSION} https://github.com/tribut/homeassistant-docker-venv.git .

FROM homeassistant/home-assistant:2022.2@sha256:e5f2de338df12ba3ee3219315780a8da163ce1085156e71ee840ab93b817303d

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
