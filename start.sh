#!/bin/bash

if [ -f "/OLAINDEX/.env" ]; then
    if [ ! -d "./storage/app" ]; then
        mv -n storage_bak/* storage/
    fi

    rm -rf storage_bak/
    chmod -R 777 storage/

    php artisan key:generate << EOF
    yes
EOF

    php artisan migrate --seed << EOF
    yes
EOF

    supervisord

else
    echo "Please add env first!"
fi