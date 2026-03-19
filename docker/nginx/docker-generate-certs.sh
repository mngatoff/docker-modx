#!/bin/sh

set -e

CERT_DIR="/etc/nginx/certs"
CERT_FILE="${CERT_DIR}/server.crt"
KEY_FILE="${CERT_DIR}/server.key"

if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
    echo "SSL certificate or key not found. Generating self-signed certificates..."
    
    mkdir -p "$CERT_DIR"
    
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout "$KEY_FILE" \
        -out "$CERT_FILE" \
        -subj "/C=CH/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"
    
    echo "Certificates generated successfully."
else
    echo "SSL certificate and key already exist."
fi
