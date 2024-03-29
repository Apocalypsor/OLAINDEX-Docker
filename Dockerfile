FROM webdevops/php-nginx:7.4-alpine

WORKDIR /OLAINDEX

COPY OLAINDEX /OLAINDEX
COPY default.conf /tmp
COPY start.sh /
COPY crons /OLAINDEX/crons

RUN set -xe \
    && composer install -vvv \
    && chown -R www-data:www-data * \
    && composer run install-app \
    && composer require predis/predis \
    && cp -r storage storage_bak \
    && mv -f /tmp/default.conf /opt/docker/etc/nginx/vhost.conf \
    && sed -i "s?\$proxies;?\$proxies=\'\*\*\';?" /OLAINDEX/app/Http/Middleware/TrustProxies.php \
    && cat /OLAINDEX/crons/cronjobs >> /etc/crontabs/root \
    && chmod +x /start.sh /OLAINDEX/crons/cache.sh

VOLUME /OLAINDEX/storage

CMD /start.sh
