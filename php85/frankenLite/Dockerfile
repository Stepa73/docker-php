FROM dunglas/frankenphp:1-php8.5-bookworm

LABEL maintainer="GAZi"

ARG NODE_VERSION=22

ENV DEBIAN_FRONTEND=noninteractive
ENV DOC_ROOT=/var/www/html

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_VERSION}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && install-php-extensions mbstring pdo_mysql zip exif pcntl gd memcached mysqli redis intl gmp pdo_sqlite \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' $PHP_INI_DIR/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 100M/g' $PHP_INI_DIR/php.ini && \
    sed -i 's/memory_limit = 128M/memory_limit = 500M/g' $PHP_INI_DIR/php.ini && \
    sed -i 's/error_reporting = E_ALL/error_reporting = E_ALL \& ~E_DEPRECATED/g' $PHP_INI_DIR/php.ini

COPY ./Caddyfile /etc/caddy/Caddyfile
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 443 443/udp

ENTRYPOINT ["/entrypoint.sh"]
