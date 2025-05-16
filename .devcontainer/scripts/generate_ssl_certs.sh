#!/bin/bash

# Create the certificates directory if it doesn't exist
mkdir -p /workspace/.devcontainer/certs

# Generate a self-signed certificate for development
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /workspace/.devcontainer/certs/qos.key \
  -out /workspace/.devcontainer/certs/qos.crt \
  -subj "/C=CA/ST=Alberta/L=Edmonton/O=Organization/CN=qos"

# Set proper permissions
chmod 644 /workspace/.devcontainer/certs/qos.crt
chmod 600 /workspace/.devcontainer/certs/qos.key

echo "SSL certificates generated successfully with CN=qos in Edmonton, AB, Canada."
