#!/usr/bin/env bash

set -e

echo "Starting Honeynet deployment..."

cd terraform

terraform init
terraform apply -auto-approve

echo "Infrastructure deployed."

IPS=$(terraform output -json honeypot_ips | jq -r '.[]')

echo "Configuring honeypots with Ansible..."

echo "[honeynet]" > ../ansible/inventory.ini

for IP in $IPS; do
  echo "$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/honeynet_key" >> ../ansible/inventory.ini
done

cd ..

export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -i ansible/inventory.ini ansible/playbooks/install_honeypot.yml

echo "Deployment complete."