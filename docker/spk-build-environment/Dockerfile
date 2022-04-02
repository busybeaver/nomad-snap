FROM debian:stable-slim

# https://global.download.synology.com/download/Document/Software/DeveloperGuide/Firmware/DSM/7.0/enu/DSM_Developer_Guide_7_0_Beta.pdf
# https://kb.synology.com/en-us/DSM/tutorial/What_kind_of_CPU_does_my_NAS_have

LABEL org.opencontainers.image.title="A minimal SPK build environment" \
      org.opencontainers.image.description="A Debian based minimal Synology package (SPK) build environment; " \
      org.opencontainers.image.base.name="debian:stable-slim" \
      org.opencontainers.image.authors="busybeaver" \
      org.opencontainers.image.source="https://github.com/busybeaver/homelab-packages"
      
ARG DSM_VERSION="7.0"

WORKDIR /toolkit

RUN apt-get update && \
    apt-get upgrade --no-install-recommends --yes && \
    apt-get install cifs-utils python3 python3-pip --no-install-recommends --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN git clone https://github.com/SynologyOpenSource/pkgscripts-ng . && \
    git checkout DSM7.0 && \
    # run for all required platforms; see documentation above
    ./EnvDeploy -v ${DSM_VERSION} -p apollolake
