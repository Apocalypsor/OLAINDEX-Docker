FROM webdevops/php-nginx:7.4-alpine

ARG COMMIT=758df5a02f2827d930213627525a58fd6fc47947

WORKDIR /OLAINDEX

COPY default.conf /tmp
COPY start.sh /
COPY cert.sh /tmp

RUN git clone https://github.com/WangNingkai/OLAINDEX.git tmp \
    && mv tmp/.git . \
    && rm -rf tmp \
    && git reset --hard \
    && composer install -vvv \
    && chown -R www-data:www-data * \
    && composer run install-app \
    && composer require predis/predis \
    && cp -r storage storage_bak \
    && cat /tmp/default.conf > /opt/docker/etc/nginx/vhost.conf \
    && mkdir /Cert && mv /tmp/cert.sh /Cert/ && cd /Cert && bash cert.sh \
    && chmod +x /start.sh

VOLUME /OLAINDEX/storage

CMD /start.sh
