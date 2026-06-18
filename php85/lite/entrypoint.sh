#!/bin/bash
set -e

if [ $# -gt 0 ]; then
    exec "$@"
fi

sed -i "s|DocumentRoot .*|DocumentRoot ${DOC_ROOT}|" /etc/apache2/sites-available/000-default.conf

exec apache2-foreground
