FROM ubuntu:24.04

LABEL maintainer="GAZi"

ARG NODE_VERSION=22

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV LANG=C.UTF-8
ENV DOC_ROOT=/var/www/html

WORKDIR /var/www/html

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg \
    curl \
    ca-certificates \
    zip \
    unzip \
    git \
    && mkdir -p /etc/apt/keyrings \
    && curl -sS 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xb8dc7e53946656efbce4c1dd71daeaab4ad4cab6' | gpg --dearmor | tee /etc/apt/keyrings/ppa_ondrej_php.gpg > /dev/null \
    && echo "deb [signed-by=/etc/apt/keyrings/ppa_ondrej_php.gpg] https://ppa.launchpadcontent.net/ondrej/php/ubuntu noble main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2 \
    libapache2-mod-php8.5 \
    php8.5-cli \
    php8.5-mysql \
    php8.5-mbstring \
    php8.5-zip \
    php8.5-gd \
    php8.5-memcached \
    php8.5-redis \
    php8.5-intl \
    php8.5-gmp \
    php8.5-sqlite3 \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_VERSION}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && a2enmod headers rewrite \
    && ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN printf '%s\n' \
    'upload_max_filesize = 100M' \
    'post_max_size = 100M' \
    'memory_limit = 500M' \
    'error_reporting = E_ALL & ~E_DEPRECATED' \
    > /etc/php/8.5/apache2/conf.d/99-custom.ini \
    && cp /etc/php/8.5/apache2/conf.d/99-custom.ini /etc/php/8.5/cli/conf.d/99-custom.ini

RUN printf '%s\n' '#!/bin/bash' 'set -e' 'if [ -f /etc/apache2/envvars ]; then . /etc/apache2/envvars; fi' 'exec apache2 -DFOREGROUND "$@"' > /usr/local/bin/apache2-foreground \
    && chmod +x /usr/local/bin/apache2-foreground

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 5173

STOPSIGNAL SIGWINCH

ENTRYPOINT ["/entrypoint.sh"]
