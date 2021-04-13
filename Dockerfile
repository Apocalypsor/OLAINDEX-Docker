FROM webdevops/php-nginx:7.4-alpine

ARG COMMIT=a26885272f584f2558dc39418c6f52f267568368

WORKDIR /OLAINDEX

COPY default.conf /tmp
COPY start.sh /
COPY crons /OLAINDEX/crons

RUN set -xe \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/WangNingkai/OLAINDEX.git tmp \
    && mv tmp/.git . \
    && rm -rf tmp \
    && git reset --hard $COMMIT \
    && composer install -vvv \
    && chown -R www-data:www-data * \
    && composer run install-app \
    && composer require predis/predis \
    && cp -r storage storage_bak \
    && cat /tmp/default.conf > /opt/docker/etc/nginx/vhost.conf \
    && sed -i "s?\$proxies;?\$proxies=\'\*\*\';?" /OLAINDEX/app/Http/Middleware/TrustProxies.php \
    && cat /OLAINDEX/crons/cronjobs >> /etc/crontabs/root \
    && chmod +x /start.sh /OLAINDEX/crons/cache.sh

VOLUME /OLAINDEX/storage

CMD /start.sh
