# syntax=docker/dockerfile:1
FROM alpine/git:v2.36.3@sha256:1dc958bc2b4770e2686acc73e23b8050b0d1b9e22c128b6fa39f5283874ad6cf as build

# renovate: datasource=github-tags depName=tribut/homeassistant-docker-venv versioning=loose
ARG GIT_TAG_VERSION="v2.3"

WORKDIR /tmp/homeassistant-docker-venv
RUN git clone --depth 1 --branch ${GIT_TAG_VERSION} https://github.com/tribut/homeassistant-docker-venv.git .

FROM homeassistant/home-assistant:2022.12@sha256:1b4a62627444841ad222aaf3795b90581c2f8b712762c8d7d6b6cf9a42045ea8

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
RUN apk --update-cache --no-cache upgrade
