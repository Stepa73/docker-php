FROM php:7.4-fpm-alpine

LABEL maintainer="GAZi"

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apk update && apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    jpegoptim optipng pngquant gifsicle \
    unzip \
    libzip-dev \
    nginx \
    curl-dev \
    pkgconfig \
    memcached \
    oniguruma-dev \
    supervisor \
    autoconf \
    build-base

# Install php extensions
RUN docker-php-ext-install pdo_mysql zip mbstring exif pcntl gd

# Install Redis extension
RUN apk add --no-cache pcre-dev $PHPIZE_DEPS \
        && pecl install redis \
        && docker-php-ext-enable redis.so

# Install MongoDB extension
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# Install Memcached extension
RUN apk --no-cache add libmemcached-libs libmemcached && \
    apk --no-cache add --virtual .memcached-deps zlib-dev libmemcached-dev && \
    pecl install memcached && \
    docker-php-ext-enable memcached && \
    apk del .memcached-deps

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clear cache
RUN apk del build-base openssl-dev autoconf && rm -rf /var/cache/apk/*
