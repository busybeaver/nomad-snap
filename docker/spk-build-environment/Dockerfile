FROM alpine/git:v2.32.0@sha256:a8a31155488a93a4d8abb834777c7b5f9d7c93db6051defbad8cc066b4e90072 as build

ENV GIT_TAG_VERSION="DSM7.0"
WORKDIR /tmp/pkgscripts-ng
RUN git clone --depth 1 --branch ${GIT_TAG_VERSION} https://github.com/SynologyOpenSource/pkgscripts-ng.git .


FROM debian:stable-slim@sha256:a04e8ec615db03154299695a65f7a85b8800a4e7878d241871419d3878e3662d

LABEL org.opencontainers.image.title="A minimal SPK build environment" \
      org.opencontainers.image.description="A Debian based minimal Synology package (SPK) build environment; " \
      org.opencontainers.image.base.name="debian:stable-slim" \
      org.opencontainers.image.authors="busybeaver" \
      org.opencontainers.image.source="https://github.com/busybeaver/homelab-packages"
      
ARG DSM_VERSION="7.0"

WORKDIR /toolkit

# https://global.download.synology.com/download/Document/Software/DeveloperGuide/Firmware/DSM/7.0/enu/DSM_Developer_Guide_7_0_Beta.pdf
# https://kb.synology.com/en-us/DSM/tutorial/What_kind_of_CPU_does_my_NAS_have

RUN apt-get update && \
    apt-get upgrade --no-install-recommends --yes && \
    apt-get install cifs-utils=2:\* python3=3.\* python3-pip=20.\* --no-install-recommends --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir ./build_env

COPY --from=build /tmp/pkgscripts-ng ./pkgscripts-ng
# run for all required platforms; see documentation above
RUN find . && ./pkgscripts-ng/EnvDeploy -v ${DSM_VERSION} -p apollolake
