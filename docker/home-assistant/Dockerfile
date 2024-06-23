# syntax=docker/dockerfile:1@sha256:e87caa74dcb7d46cd820352bfea12591f3dba3ddc4285e19c7dcd13359f7cefd
FROM alpine/git:2.45.2@sha256:384f836c368dc8bc0cc4a34c8a6a577dfc3285affd88ec0c2f5d1afa5a7373ac as build

# renovate: datasource=github-tags depName=tribut/homeassistant-docker-venv versioning=loose
ARG GIT_TAG_VERSION="v2.3"

WORKDIR /tmp/homeassistant-docker-venv
RUN git clone --depth 1 --branch ${GIT_TAG_VERSION} https://github.com/tribut/homeassistant-docker-venv.git .

FROM homeassistant/home-assistant:2024.6@sha256:17d159928122e6f374bd39b0e75904522bc7d7c2a64e88b248948734e4c4d444

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
