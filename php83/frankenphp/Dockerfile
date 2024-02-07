FROM dunglas/frankenphp:latest-php8.3

LABEL maintainer="GAZi"

# Set working directory
WORKDIR /app

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
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    supervisor


# Install php extensions
RUN install-php-extensions \
      mbstring \
      pdo_mysql \
      zip \
      exif \
      pcntl \
      gd \
      memcached \
      mysqli \
      redis \
      intl \
      gmp \
      pdo_sqlite

## Change php.ini conf
RUN cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' $PHP_INI_DIR/php.ini && \
   sed -i 's/post_max_size = 8M/post_max_size = 100M/g' $PHP_INI_DIR/php.ini && \
   sed -i 's/memory_limit = 128M/memory_limit = 500M/g' $PHP_INI_DIR/php.ini

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

## Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443 443/udp
