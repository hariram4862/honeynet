#!/usr/bin/env bash

set -e

echo "Starting Honeynet deployment..."
echo "Initializing Terraform..."

cd terraform

terraform init

echo "Applying Terraform configuration..."
terraform apply -auto-approve

echo "Deployment complete."