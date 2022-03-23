# Allow to run Caddy on privileged ports (as a non-root user)

FROM caddy:alpine

RUN apk --update-cache --no-cache add libcap=~2.50 && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
