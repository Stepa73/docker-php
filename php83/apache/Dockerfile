FROM php:8.3-apache

LABEL maintainer="GAZi"

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    unzip \
    git \
    curl \
    lua-zlib-dev \
    libmemcached-dev \
    nginx \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    supervisor

# Add docker php ext repo
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install php extensions
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions mbstring pdo_mysql zip exif pcntl gd memcached mysqli redis intl gmp pdo_sqlite

# Change php.ini conf
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' /usr/local/etc/php/php.ini && \
   sed -i 's/post_max_size = 8M/post_max_size = 100M/g' /usr/local/etc/php/php.ini && \
   sed -i 's/memory_limit = 128M/memory_limit = 500M/g' /usr/local/etc/php/php.ini

# Enable headers/rewrite module for Apache
RUN a2enmod headers rewrite

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 80
