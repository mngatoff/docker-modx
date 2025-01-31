#!/bin/bash
echo "Preparing MODX..."
echo "Copying MODX..."
mv $MODX_SOURCE_PATH/modx/* $HTML_ROOT

echo "Installing dependencies..."
composer install --working-dir=$HTML_ROOT

echo "Configuring MODX..."
cp $HTML_ROOT/_build/build.config.sample.php $HTML_ROOT/_build/build.config.php
cp $HTML_ROOT/_build/build.properties.sample.php $HTML_ROOT/_build/build.properties.php

buildConfig="<?php
/* define the MODX path constants necessary for core installation */
define('MODX_CORE_PATH', dirname(__DIR__) . '/core/');
define('MODX_CONFIG_KEY', 'config');
/* define the connection variables */
define('XPDO_DSN', 'mysql:host=$MODX_DATABASE_SERVER;dbname=$MYSQL_DATABASE;charset=$MODX_DATABASE_CONNECTION_CHARSET');
define('XPDO_DB_USER', '$MYSQL_USER');
define('XPDO_DB_PASS', '$MYSQL_PASSWORD');
define('XPDO_TABLE_PREFIX', '$MODX_TABLE_PREFIX');
"
echo "$buildConfig" > $HTML_ROOT/_build/build.config.php

echo "Building MODX..."
php $HTML_ROOT/_build/transport.core.php
rm -r $HTML_ROOT/_build

echo "Fixing permissions..,"
chmod -R 0755 $HTML_ROOT

if [[ $MODX_INSTALL_TYPE == "cli" ]]; then
    bash $ENTRYPOINT_PATH/docker-modx-cli-install.sh;
fi

echo "Cleaning up..."
rm \
  $HTML_ROOT/*.md \
  $HTML_ROOT/*.yml \
  $HTML_ROOT/*.json \
  $HTML_ROOT/composer.lock \
  $HTML_ROOT/phpcs.xml \
  $HTML_ROOT/COPYRIGHT \
  $HTML_ROOT/LICENSE

echo "MODX is ready"
