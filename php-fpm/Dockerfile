# Base PHP image for building and setting up MODX
FROM php:8.2-fpm AS develop

# Variables
ENV MODX_VERSION 3.1.0
ENV MODX_SOURCE_PATH /var/www/src
ENV HTML_ROOT=/var/www/html
ENV ENTRYPOINT_PATH /usr/local/bin

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    libmagickwand-dev \
    libzip-dev \
    unzip \
    curl \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install \
        gd \
        pdo_mysql \
        mysqli \
        simplexml \
        curl \
        mbstring \
        ftp \
        zip \
    && pecl install \
        imagick \
        xdebug-3.3.0 \
    && docker-php-ext-enable \
        imagick \
        xdebug \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/pear

# Copy helper scripts and set executable permissions
COPY docker-container-start.sh docker-modx-prepare.sh docker-modx-cli-install.sh $ENTRYPOINT_PATH/
RUN chmod 0755 \
        $ENTRYPOINT_PATH/docker-container-start.sh \
        $ENTRYPOINT_PATH/docker-modx-prepare.sh \
        $ENTRYPOINT_PATH/docker-modx-cli-install.sh

# Use entrypoint with additional check of Modx installment
ENTRYPOINT ["/usr/local/bin/docker-container-start.sh"]

# Final production image
FROM php:8.2-fpm AS production

# Install minimal production dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6 \
    libjpeg62-turbo \
    libpng16-16 \
    libwebp6 \
    libxml2 \
    libcurl4 \
    libonig5 \
    libmagickwand-6.q16-6 \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install \
        gd \
        pdo_mysql \
        mysqli \
        simplexml \
        curl \
        mbstring \
#        # - endble ftp, if the project uses remote media sources
#        ftp \
        opcache \
    && pecl install imagick \
    && docker-php-ext-enable \
        imagick \
        opcache \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/pear

# Set production configuration for php.ini
COPY ./php-fpm/config/production.ini /usr/local/etc/php/php.ini
# Copy Composer installed in the buislder
COPY --from=develop /usr/local/bin/composer /usr/local/bin/composer

# Use lightweight entrypoint
ENTRYPOINT ["docker-php-entrypoint", "php-fpm"]
