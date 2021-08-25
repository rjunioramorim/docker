#!/bin/bash

#On error no such file entrypoint.sh, execute in terminal - dos2unix .docker\entrypoint.sh
chown -R www-data:www-data .
cp ./docker/app/.env.example ${APP_NAME}/.env
cp ./docker/app/env.testing ${APP_NAME}/.env.testing

cd ${APP_NAME}/
composer install
php artisan key:generate
php artisan migrate

php-fpm