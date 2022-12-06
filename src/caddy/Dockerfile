ARG CADDY_VERSION=2.6

FROM caddy:${CADDY_VERSION}-builder-alpine AS caddy_builder

RUN xcaddy build \
	--with github.com/dunglas/vulcain \
	--with github.com/dunglas/vulcain/caddy

FROM caddy:${CADDY_VERSION}

WORKDIR /var/www

COPY --from=caddy_builder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
