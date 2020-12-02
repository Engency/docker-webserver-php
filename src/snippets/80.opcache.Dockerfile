####################################
#                                  #
#            opcache               #
#                                  #
####################################

COPY config/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# 0 = OPcache will NOT check for updates. Updates will take effect on restarting the webserver (or opcache_invalidate())
# any value greater than 0 = OPcache will check every x seconds for updates.
# https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.validate-timestamps
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"

# https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.max-accelerated-files
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES="32531"

# https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.memory-consumption
ENV PHP_OPCACHE_MEMORY_CONSUMPTION="256"

# https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.max-wasted-percentage
ENV PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

RUN docker-php-ext-install opcache
