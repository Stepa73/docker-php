#!/bin/bash
set -e

if [ $# -gt 0 ]; then
    exec "$@"
fi

sed -i "s|root \* .*|root * ${DOC_ROOT}|" /etc/caddy/Caddyfile

exec frankenphp run --config /etc/caddy/Caddyfile
