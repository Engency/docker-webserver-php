FROM php:8.4.11-fpm-bullseye

WORKDIR /var/www/html
ENV PATH /var/www/html:$PATH

RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf

RUN apt-get update \
        && apt-get install -y zlib1g-dev libzip-dev unzip sqlite3 libsqlite3-dev \
        zlib1g-dev libzip-dev libssl-dev libmcrypt-dev wget --no-install-recommends \
        && docker-php-ext-install pdo pdo_mysql pdo_sqlite zip exif pcntl bcmath

# Install pickle
RUN wget https://github.com/FriendsOfPHP/pickle/releases/download/v0.6.0/pickle.phar && mv pickle.phar /usr/local/bin/pickle && chmod u+x /usr/local/bin/pickle

# install APCu
RUN pickle install apcu && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini

# install gd
RUN buildDeps=" \
        libfreetype6-dev \
        libjpeg-dev \
        libwebp-dev \
        libjpeg62-turbo-dev \
        libxpm-dev \
        libpng-dev \
    "; \
    set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# install tidy
RUN apt install -y zlib1g-dev libzip-dev libtidy-dev && docker-php-ext-install tidy && docker-php-ext-enable tidy

# install intl
RUN apt-get -y update \
    && apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

COPY config/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf

RUN sed -E -i -e 's/expose_php = On/expose_php = Off/' /usr/local/etc/php/php.ini-production \
 && sed -E -i -e 's/log_errors = Off/log_errors = On/' /usr/local/etc/php/php.ini-production

RUN ln -s /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

#include 03.tz-amsterdam.Dockerfile
#include 04.locale-dutch.Dockerfile
#include 20.composer.Dockerfile

RUN usermod -u 1000 www-data
RUN groupmod --gid 1000 www-data
RUN chown -R www-data:www-data /var/www
