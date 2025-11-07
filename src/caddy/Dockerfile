ARG CADDY_VERSION=2.10.2

FROM caddy:${CADDY_VERSION}-builder-alpine AS caddy_builder

RUN xcaddy build  \
    --with github.com/mpilhlt/caddy-conneg  \
    --with github.com/caddyserver/replace-response

FROM caddy:${CADDY_VERSION}

WORKDIR /var/www

COPY --from=caddy_builder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
