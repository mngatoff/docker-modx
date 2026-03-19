# Introduction

MODX on LNMP (Linux, Nginx, MySQL (MariaDB), PHP8) using Docker.
* Auto-installation with cli
* Configured Friendly URLs on a NGINX server
* Self-signed SSL Certificate issue for HTTPS

This repsoitory is based on [docker-modx](https://github.com/pinguinens/docker-modx) by Pinguinens, but at the moment it has been modified so much that it is not compatible with the original, and therefore could not be considered as a fork anymore.

### Contents

* MODX 3.2.0 (or 2.8.8, or whatever you want)
* PHP 8.4
* MaraiaDB 11.6
* NGINX latest

### Configuration

Rename `/.env-example` to `/.env` and edit it to your needs.

**IMPORTANT:** Changing manager and connectors paths via `.env` does not work at the moment.

### Build and Run

    $ docker-compose up
  
You can now access your project at `https://localhost:{YOUR_HTTPS_PORT}`.

MODX is being installed at the first run, if does not exist in `/app/public/`.  
If the folder contains a `config.core.php` file, this step is skipped.
