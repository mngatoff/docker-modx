FROM php:8.4-fpm-alpine

ARG MODX_VERSION=3.2.0
ENV MODX_VERSION=$MODX_VERSION
ENV MODX_SOURCE_PATH=/var/www/src
ENV HTML_ROOT=/var/www/html
ENV ENTRYPOINT_PATH=/usr/local/bin

RUN apk add --no-cache \
    autoconf \
    build-base \
    curl \
    curl-dev \
    imagemagick-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxml2-dev \
    libzip-dev \
    oniguruma-dev \
    pkgconfig \
    unzip \
    && docker-php-ext-configure gd \
        --with-jpeg \
        --with-webp \
    && docker-php-ext-install \
        curl \
        ftp \
        gd \
        mbstring \
        mysqli \
        pdo_mysql \
        simplexml \
        zip \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && sed -i 's|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|' /usr/local/etc/php-fpm.d/www.conf

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

COPY docker-container-start.sh docker-modx-prepare.sh docker-modx-cli-install.sh $ENTRYPOINT_PATH/
RUN chmod 0755 \
    $ENTRYPOINT_PATH/docker-container-start.sh \
    $ENTRYPOINT_PATH/docker-modx-prepare.sh \
    $ENTRYPOINT_PATH/docker-modx-cli-install.sh

ENTRYPOINT ["/usr/local/bin/docker-container-start.sh"]
