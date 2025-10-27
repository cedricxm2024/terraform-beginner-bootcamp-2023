#!/usr/bin/env bash

set -e

# Check if AWS CLI is already installed
if command -v aws &> /dev/null; then
  echo "AWS CLI is already installed: $(aws --version)"
  exit 0
fi

echo "Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install

# Cleanup
rm -rf awscliv2.zip aws/

echo "AWS CLI installed successfully: $(aws --version)"