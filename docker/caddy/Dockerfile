# Allow to run Caddy on privileged ports (as a non-root user)

FROM caddy:alpine@sha256:f95672886ddd6284ccba4b0be903d0d0949d7c665f5e7acc96cc6a0af2467364

RUN apk --update-cache --no-cache add libcap=~2.50 && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
