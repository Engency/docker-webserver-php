####################################
#                                  #
#            XDebug  3.2           #
#                                  #
####################################

ARG XDEBUG_VERSION="3.2.0RC2"
ARG XDEBUG_CONFIG="client_host=172.17.0.1"
ARG PHP_IDE_CONFIG="serverName=webserver"

COPY config/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# install xdebug 3.2
RUN cd /usr/local/lib/php/extensions/ \
    && wget https://github.com/xdebug/xdebug/archive/refs/tags/$XDEBUG_VERSION.tar.gz \
    && mkdir xdebug && tar -zxC ./xdebug -f $XDEBUG_VERSION.tar.gz --strip-components 1 \
    && rm  $XDEBUG_VERSION.tar.gz

# the last working commit, because the php-src is not up to date yet in this alpine
RUN cd /usr/local/lib/php/extensions/xdebug \
    && phpize \
    && ./configure --enable-xdebug-dev \
    && make all
