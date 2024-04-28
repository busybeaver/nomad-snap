# syntax=docker/dockerfile:1@sha256:a57df69d0ea827fb7266491f2813635de6f17269be881f696fbfdf2d83dda33e
FROM alpine/git:v2.43.0@sha256:c15c54221625d866fb6a98e74dcb1c6c4a24ab7c6585632db07f45219ea17efd as build

# renovate: datasource=github-tags depName=tribut/homeassistant-docker-venv versioning=loose
ARG GIT_TAG_VERSION="v2.3"

WORKDIR /tmp/homeassistant-docker-venv
RUN git clone --depth 1 --branch ${GIT_TAG_VERSION} https://github.com/tribut/homeassistant-docker-venv.git .

FROM homeassistant/home-assistant:2024.4@sha256:73b70d36610466a46f1ae3b890bc43f06b48a1ac98b4f28c5d52cf424e476cd5

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://127.0.0.1:8123 || exit 1

ARG HOME_ASSISTANT_ENTRYPOINT="/etc/services.d/home-assistant/run"

# This is a simple build time check to ensure that the home assistant
# entry point didn't change in the base/parent image. without this
# check, a changed entry point would only be detected "later" during
# runtime (which is obviously not desirable)
RUN cat ${HOME_ASSISTANT_ENTRYPOINT} > /dev/null

# Copy/override the entry point of home-assistant, allows to run home-assistant as non-root user
COPY --from=build /tmp/homeassistant-docker-venv/run ${HOME_ASSISTANT_ENTRYPOINT}

# Update outdated (and potentially vulnerable) dependencies
RUN --mount=type=cache,id=apk,sharing=locked,target=/var/cache/apk \
    apk --update-cache upgrade
