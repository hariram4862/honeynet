# Honeynet

Honeynet is a scalable, cloud-native framework for deploying and managing distributed honeypots across multiple geographic regions. It automates the provisioning, configuration, and monitoring of honeypot infrastructure using **Terraform** and **Ansible**.

The goal of the project is to help security researchers and organizations collect threat intelligence, analyze attacker behavior, and improve defensive strategies by simulating realistic targets in cloud environments.

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)

---

# Table of Contents

* Overview
* Architecture
* Key Features
* Repository Structure
* Getting Started
* Deployment
* Data Collection
* Development
* Contributing
* License

---

# Overview

Modern cyber threats originate from different regions across the globe. Understanding attacker behavior requires collecting data from distributed environments.

Honeynet provides a framework that allows security teams to deploy honeypot systems across multiple cloud providers and geographic regions using Infrastructure-as-Code.

```
Controller Node
        │
        ▼
┌──────────────────────────────┐
│ Infrastructure Automation    │
│ (Terraform)                  │
└───────────┬──────────────────┘
            │
      Multi-Region Deployment
            │
     ┌──────┴───────┐
     ▼              ▼
 Honeypot Node   Honeypot Node
 (Region A)      (Region B)
     │              │
     └──────┬───────┘
            ▼
   Attack Logs & Intelligence
```

---

# Architecture

The system follows a distributed deployment architecture inspired by global scanning systems.

### Components

**Controller Node**

The central orchestration node responsible for:

* provisioning infrastructure
* executing automation workflows
* collecting attack data

**Terraform**

Used for Infrastructure-as-Code deployment of:

* virtual machines
* networking
* security groups
* cloud resources

**Ansible**

Responsible for configuring honeypot nodes:

* installing honeypot software
* configuring services
* managing system dependencies

**Honeypot Nodes**

Deployed globally to simulate vulnerable services such as:

* SSH
* web servers
* network services

These nodes capture attacker interactions and generate logs.

---

# Key Features

| Feature                        | Description                                         |
| ------------------------------ | --------------------------------------------------- |
| Distributed Deployment         | Deploy honeypots across multiple geographic regions |
| Infrastructure as Code         | Terraform-based infrastructure provisioning         |
| Automated Configuration        | Ansible playbooks for system setup                  |
| Threat Intelligence Collection | Capture and analyze attacker behavior               |
| Multi-Cloud Support            | Compatible with AWS, Azure, and GCP                 |

---

# Repository Structure

```
honeynet/

terraform/
    main.tf
    provider.tf
    variables.tf

ansible/
    playbooks/
        install_honeypot.yml

scripts/
    deploy_honeypots.sh

honeypots/
    cowrie/
    dionaea/

docs/
    architecture.md
```

---

# Getting Started

## Prerequisites

Ensure the following tools are installed:

* Terraform
* Ansible
* Git
* Access to a cloud provider (AWS / Azure / GCP)

---

# Deployment

Clone the repository:

```bash
git clone https://github.com/c2si0rg/honeynet.git
cd honeynet
```

Initialize Terraform:

```bash
terraform init
```

Apply infrastructure configuration:

```bash
terraform apply
```

Or use the deployment script:

```bash
bash scripts/deploy_honeypots.sh
```

---

# Data Collection

Honeypot nodes collect various types of attack data including:

* login attempts
* command execution attempts
* malware uploads
* network scanning behavior

These logs can later be aggregated and analyzed to extract threat intelligence.

---

# Development

To start development:

```bash
git clone https://github.com/c2si0rg/honeynet.git
cd honeynet
```

Modify Terraform modules, Ansible playbooks, or scripts as needed.

Future development will focus on:

* improved multi-region deployment
* centralized logging
* analytics pipelines
* integration with threat intelligence platforms

---

# Contributing

Contributions are welcome.

You can contribute by:

* improving infrastructure modules
* adding support for new honeypots
* improving automation scripts
* enhancing documentation

Before submitting a pull request:

* keep PRs focused and minimal
* ensure code is properly formatted
* include documentation when adding features

---

# License

This project is licensed under the **Apache 2.0 License**. See the [LICENSE](LICENSE) file for details.
