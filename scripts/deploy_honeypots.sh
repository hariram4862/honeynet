#!/usr/bin/env bash

set -e

echo "Starting Honeynet deployment..."

cd terraform

terraform init
terraform apply -auto-approve

echo "Infrastructure deployed."

IP=$(terraform output -raw honeypot_ip)

echo "Configuring honeypots with Ansible..."

echo "[honeynet]" > ../ansible/inventory.ini
echo "$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/honeynet_key" >> ../ansible/inventory.ini

cd ..

ansible-playbook -i ansible/inventory.ini ansible/playbooks/install_honeypot.yml

echo "Deployment complete."