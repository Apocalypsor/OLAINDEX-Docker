FROM webdevops/php-nginx:7.4-alpine

WORKDIR /OLAINDEX

COPY default.conf /opt/docker/etc/nginx/conf.d
COPY start.sh /

RUN git clone https://github.com/WangNingkai/OLAINDEX.git tmp \
    && mv tmp/.git . \
    && rm -rf tmp \
    && git reset --hard \
    && composer install -vvv \
    && chown -R www-data:www-data * \
    && composer run install-app \
    && cp -r storage storage_bak \
    && echo > /opt/docker/etc/nginx/vhost.conf \
    && chmod +x /start.sh

VOLUME /OLAINDEX/storage

CMD /start.sh
