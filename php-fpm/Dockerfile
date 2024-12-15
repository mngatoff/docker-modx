FROM php:8.2-fpm

ENV MODX_VER 3.0.5
ENV ENTRYPOINT_PATH /usr/local/bin
ENV SRC_ROOT /var/www/src

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    libmagickwand-dev \
    unzip \
    && docker-php-ext-configure gd \
        --with-freetype=/usr/include/ \
        --with-jpeg=/usr/include/ \
        --with-webp=/usr/include/ \
    && docker-php-ext-install \
        gd \
        pdo_mysql \
        mysqli \
        simplexml \
        curl \
        mbstring \
        zip \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/pear

RUN mkdir -p ${SRC_ROOT} \
    && mkdir -p ${SRC_ROOT}/modx \
    && curl -o ${SRC_ROOT}/modx.tar.gz -SL https://github.com/modxcms/revolution/archive/v${MODX_VER}-pl.tar.gz \
    && tar xfvz ${SRC_ROOT}/modx.tar.gz -C ${SRC_ROOT}/modx --strip=1 \
        revolution-${MODX_VER}-pl/connectors \
        revolution-${MODX_VER}-pl/core \
        revolution-${MODX_VER}-pl/manager \
        revolution-${MODX_VER}-pl/setup \
        revolution-${MODX_VER}-pl/_build \
        revolution-${MODX_VER}-pl/index.php \
        revolution-${MODX_VER}-pl/ht.access

COPY docker-container-start.sh docker-modx-prepare.sh docker-modx-cli-install.sh $ENTRYPOINT_PATH/

RUN chmod 0777 \
        $ENTRYPOINT_PATH/docker-container-start.sh \
        $ENTRYPOINT_PATH/docker-modx-prepare.sh \
        $ENTRYPOINT_PATH/docker-modx-cli-install.sh \
    && chmod +x \
        $ENTRYPOINT_PATH/docker-container-start.sh \
        $ENTRYPOINT_PATH/docker-modx-prepare.sh \
        $ENTRYPOINT_PATH/docker-modx-cli-install.sh

ENTRYPOINT ["/usr/local/bin/docker-container-start.sh"]