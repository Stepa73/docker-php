#!/bin/bash

# Replace DocumentRoot dynamically
sed -i "s|DocumentRoot .*|DocumentRoot ${DOC_ROOT}|" /etc/apache2/sites-available/000-default.conf

# Start Apache
exec apache2ctl -D FOREGROUND
