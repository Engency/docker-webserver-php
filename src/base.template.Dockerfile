FROM php:8.0.5-apache

WORKDIR /var/www/html
RUN mkdir /var/www/letsencrypt
ENV PATH /var/www/html:$PATH

RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# Apache configuration
RUN a2enmod rewrite alias
COPY config/virtualserver.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update \
        && apt-get install -y zlib1g-dev libzip-dev unzip sqlite3 libsqlite3-dev \
        zlib1g-dev libzip-dev libssl-dev libmcrypt-dev wget --no-install-recommends \
        && docker-php-ext-install pdo pdo_mysql pdo_sqlite zip

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

#include 03.tz-amsterdam.Dockerfile
#include 04.locale-dutch.Dockerfile
#include 20.composer.Dockerfile
