FROM php:7.3.11-apache-buster
MAINTAINER Allen Mercer <amercat37@gmail.com>

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    apt-get update && \
    mkdir /etc/apache2/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/certs/default-ssl-cert.key -out /etc/apache2/certs/default-ssl-cert.pem -subj "/C=AT/ST=Vienna/L=Vienna/O=Security/OU=Development/CN=www.example.com" && \
    a2enmod rewrite && \
    a2ensite default-ssl && \
    a2enmod ssl && \
    sed -i "s/ssl\/private\/ssl-cert-snakeoil.key/apache2\/certs\/default-ssl-cert.key/" /etc/apache2/sites-enabled/default-ssl.conf && \
    sed -i "s/ssl\/certs\/ssl-cert-snakeoil.pem/apache2\/certs\/default-ssl-cert.pem/" /etc/apache2/sites-enabled/default-ssl.conf && \
    echo "ServerName www.example.com" >> /etc/apache2/apache2.conf && \
    mkdir -p /opt/src && \
    curl https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz --output /opt/src/dokuwiki.tgz && \
    cd /opt/src/ && \
    tar zxf dokuwiki.tgz && \
    rm -f dokuwiki.tgz && \
    mv dokuwiki* dokuwiki && \
    rm -fr /var/www/html && \
    cp -R dokuwiki /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    cp -Rp /etc/apache2 /opt/src/ && \
    service apache2 restart

EXPOSE 443 80

CMD ["/entrypoint.sh"]
