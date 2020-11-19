####################################
#                                  #
#            opcache               #
#                                  #
####################################

COPY config/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="32531" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="256" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

RUN docker-php-ext-install opcache
