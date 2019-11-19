#!/bin/bash

set -e

# Volumes Init
if [ ! -f /var/www/html/data/.htaccess ]; then
  echo "Init data folder"
  cp -R /opt/src/dokuwiki/data/ /var/www/html/
  chown -R www-data:www-data /var/www/html
fi

if [ ! -f /var/www/html/lib/index.html ]; then
  echo "Init lib folder"
  cp -R /opt/src/dokuwiki/lib/ /var/www/html/
  chown -R www-data:www-data /var/www/html
fi

if [ ! -f /var/www/html/conf/.htaccess ]; then
  echo "Init conf folder"
  cp -R /opt/src/dokuwiki/conf/ /var/www/html/
  chown -R www-data:www-data /var/www/html
fi

if [ ! -f /etc/apache2/apache2.conf ]; then
  echo "Init apache2 folder"
  cp -Rp /opt/src/apache2/ /etc/
fi

# Start Server
docker-php-entrypoint apache2-foreground
