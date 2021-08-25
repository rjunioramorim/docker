FROM php:8.0.3-fpm-alpine3.13

RUN apk add --no-cache shadow openssl bash nodejs npm postgresql-dev git
RUN docker-php-ext-install bcmath pdo pdo_pgsql

# RUN touch /home/www-data/.bashrc | echo "PS1='\w\$ '" >> /home/www-data/.bashrc

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN  apk add git 

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data

WORKDIR /var/www

RUN rm -rf /var/www/html

RUN ln -s public html

USER www-data

# COPY ./api /var/www
# RUN chmod 775 -R storage
# RUN chown www-data:www-data -R storage

EXPOSE 9000

ENTRYPOINT ["php-fpm"]