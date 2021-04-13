FROM webdevops/php-nginx:7.4-alpine

ARG COMMIT=758df5a02f2827d930213627525a58fd6fc47947

WORKDIR /OLAINDEX

COPY default.conf /tmp
COPY start.sh /
COPY crons/* /opt/cronjobs

RUN git clone https://github.com/WangNingkai/OLAINDEX.git -b $COMMIT tmp \
    && mv tmp/.git . \
    && rm -rf tmp \
    && git reset --hard \
    && composer install -vvv \
    && chown -R www-data:www-data * \
    && composer run install-app \
    && composer require predis/predis \
    && cp -r storage storage_bak \
    && cat /tmp/default.conf > /opt/docker/etc/nginx/vhost.conf \
    && sed -i "s?\$proxies;?\$proxies=\'\*\*\';?" /OLAINDEX/app/Http/Middleware/TrustProxies.php \
    && chmod +x /start.sh /opt/cronjobs/cache.sh \
    && cat /opt/cronjobs/cronjobs >> /etc/crontabs/root 

VOLUME /OLAINDEX/storage

CMD /start.sh
