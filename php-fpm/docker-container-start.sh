#!/bin/bash

bash $ENTRYPOINT_PATH/docker-php-entrypoint

if [ ! -d "$MODX_SOURCE_PATH" ] && [ ! -f "${HTML_ROOT}/config.core.php" ]; then
    echo "Development environment: Site not found. Downloading MODX...";
    mkdir -p ${MODX_SOURCE_PATH}/modx \
    && curl -o ${MODX_SOURCE_PATH}/modx.tar.gz -SL https://github.com/modxcms/revolution/archive/v${MODX_VERSION}-pl.tar.gz \
    && tar xfvz ${MODX_SOURCE_PATH}/modx.tar.gz -C ${MODX_SOURCE_PATH}/modx --strip=1 \
    && rm -rf ${MODX_SOURCE_PATH}/modx.tar.gz;
    echo "MODX downloaded to ${MODX_SOURCE_PATH}";
    bash $ENTRYPOINT_PATH/docker-modx-prepare.sh;
fi

php-fpm
