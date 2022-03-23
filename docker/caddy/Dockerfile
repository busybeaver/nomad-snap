# Allow to run Caddy on privileged ports (as a non-root user)

FROM caddy:alpine@sha256:b5a59725783bab0d65803f87028c68dd6611ca6184040bd98b18797cbe26bdd9

RUN apk --update-cache --no-cache add libcap=~2.50 && \
    setcap 'cap_net_bind_service=+eip' /usr/bin/caddy
