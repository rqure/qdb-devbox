#!/bin/bash

# Create the certificates directory in a location with proper permissions
CERT_DIR="/tmp/qos_certs"
mkdir -p $CERT_DIR

# Generate a self-signed certificate for development
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$CERT_DIR/qos.key" \
  -out "$CERT_DIR/qos.crt" \
  -subj "/C=CA/ST=Alberta/L=Edmonton/O=Organization/CN=qos"

# Set proper permissions
chmod 644 "$CERT_DIR/qos.crt"
chmod 600 "$CERT_DIR/qos.key"

# Copy the certificates to the target location if we have permission
TARGET_DIR="/workspace/.devcontainer/certs"
mkdir -p "$TARGET_DIR" 2>/dev/null

# Check if we actually have write permission to the target directory
if [ -d "$TARGET_DIR" ] && [ -w "$TARGET_DIR" ]; then
  if cp "$CERT_DIR/qos.crt" "$TARGET_DIR/" && cp "$CERT_DIR/qos.key" "$TARGET_DIR/"; then
    chmod 644 "$TARGET_DIR/qos.crt"
    chmod 600 "$TARGET_DIR/qos.key"
    echo "SSL certificates successfully copied to $TARGET_DIR"
  else
    echo "Error: Failed to copy certificates to $TARGET_DIR due to permission issues."
    echo "Certificates remain in $CERT_DIR"
    echo "Please update your docker-compose.yml to use certificates from $CERT_DIR"
  fi
else
  echo "Warning: Cannot write to $TARGET_DIR, certificates remain in $CERT_DIR"
  echo "Please update your docker-compose.yml to use certificates from $CERT_DIR"
  # You might need to adjust the docker-compose.yml volume mapping
fi

echo "SSL certificates generated successfully with CN=qos in Edmonton, AB, Canada."
echo "Certificate location: $CERT_DIR/qos.crt"
echo "Key location: $CERT_DIR/qos.key"
