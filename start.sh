#!/bin/bash

if [ -f "/OLAINDEX/.env" ]; then
    if [ ! -d "./storage/app" ]; then
        mv -n storage_bak/* storage/
    fi

    rm -rf storage_bak/
    chmod -R 777 storage/

    php artisan config:clear
    php artisan config:cache

    php artisan route:clear
    php artisan route:cache

    php artisan clear-compiled
    php artisan optimize

    supervisord

else
    echo "Please add env first!"
fi