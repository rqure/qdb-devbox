#!/bin/bash

# Create the certificates directory in a location with proper permissions
CERT_DIR="/tmp/qos_certs"
mkdir -p $CERT_DIR

# Create OpenSSL config file with SAN extension
cat > $CERT_DIR/openssl.cnf << EOF
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
C = CA
ST = Alberta
L = Edmonton
O = Qureshi Enterprise Inc
CN = qos

[v3_req]
keyUsage = digitalSignature, keyCertSign, cRLSign
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = qos
DNS.2 = localhost
EOF

# Generate a self-signed certificate for development with SAN
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$CERT_DIR/qos.key" \
  -out "$CERT_DIR/qos.crt" \
  -config "$CERT_DIR/openssl.cnf" \
  -extensions v3_req

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

echo "SSL certificates generated successfully with CN=qos and SAN=qos,localhost"
echo "Certificate location: $CERT_DIR/qos.crt"
echo "Key location: $CERT_DIR/qos.key"
