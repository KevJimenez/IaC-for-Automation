### Linter Status
[![Ansible Linter](https://github.com/KevJimenez/IaC-for-Automation/actions/workflows/ansiblelint.yml/badge.svg)](https://github.com/KevJimenez/IaC-for-Automation/actions/workflows/ansiblelint.yml)
[![Terraform Linter](https://github.com/KevJimenez/IaC-for-Automation/actions/workflows/tflint.yml/badge.svg)](https://github.com/KevJimenez/IaC-for-Automation/actions/workflows/tflint.yml)


# Automated Virtual Private Server Guide
## Overview
An automated setup of infrastracture with configuration for a web server (uses Amazon EC2 as VPS) using Terraform (IaC) and Ansible (CaC). Can be used to instantly deploy or destroy the web server and the configuration files are checked in to a GitHub repository. Used Github Actions that is run on a local Ubuntu instance for the automation of the whole process. The web server made in this project hosts my personal portfolio site.

## Diagrams:
- IaC-for-Automation

![iac](/images/iac.png)

- Whole CI/CD Pipeline of the Project [(Link to the Personal-Portfolio Repository)](https://github.com/KevJimenez/Hugo-Static)

![whole](/images/whole.png)

## The Workflow

### Preparation

1. Terraform Configuration Files
   - Made 3 tf files:
     - main.tf - contains all code related to AWS, Terraform Cloud, required providers (EC2 instance provisioning, ssh http https access, ssh key pair for host pc)
     - dnset.tf - cloudflare configuration (A-NAME Record, Cloudflare Account)
     - variables.tf - variables for referencing (variable values checked in to Terraform Cloud for security purposes)
2. Ansible Configuration Files:
   - Made 3 yaml files:
     - playbook.yml - contains code for the whole CaC in the infrastructure provisioned by Terraform (Update Instance, Installing Docker, Login to Docker, Running Docker Container Watchtower and Docker Image of Personal-Portfolio)
     - destroyinf.yml - code for the uninstallation of files present in the instance (Clean apt directories and cache, Uninstall Docker)
     - aws_ec2.yml - contains code for a dynamic inventory in my AWS account
3. GitHub Action Workflows:
   - Made 4 workflows:
     - ansiblelint.yml - workflow for ansible-lint (triggers per push into the repository)
     - tflint.yml - workflow for terraform-lint (triggers per push into the repository)
     - deploy.yml - workflow for deploying ec2 instance (triggers on dispatch)
     - destroy.yml - workflow for destroying ec2 instance (triggers on dispatch)


### Workflow Process
> Note: Workflow runners for deploy and destroy is not running on a GitHub Container. Runs on my Local Ubuntu Instance with permissions from AWS. GitHub Container runners also can't detect yaml as an inventory for ansible, hence used a local runner instead.

**Deploy Infrastructure** (deploy.yml)
   1. Terraform Init (Checks for Terraform Files)
      ```bash
       terraform init
      ```
   2. Terraform Apply (Building of the Instance)
      ```bash
      terraform apply -auto-approve -input=false
      ```
   3. Delay for 7s (Added delay because EC2 dynamic inventory takes time to detect newly built instance for the ansible playbook)
      ```bash
      sleep 7s
      ```
   4. Run Ansible Playbook (referenced github secrets for docker access key)
      ```bash
      ansible-playbook -i aws_ec2.yml playbook.yml -e "docker_key=${{ secrets.DOCKER_KEY }}"
      ```
*Output:*
- AWS EC2 Instance running docker with [Watchtower](https://github.com/containrrr/watchtower) and Containerized [Personal-Portfolio](https://github.com/KevJimenez/Personal-Portfolio).
- Personal portfolio website that can be accessed from https://kojimenez.site

**Destroy Infrastructure** (destroy.yml)
   1. Run Ansible Playbook for Uninstallation (Removes installed programs)
      ```bash
       ansible-playbook -i aws_ec2.yml destroyinf.yml
      ```
   2. Terraform Init (Checks Terraform Files)
      ```bash
      terraform init
      ```
   3. Terraform Destroy (Destroys running instance)
      ```bash
      terraform destroy -auto-approve -input=false
      ```
*Output:*
- Destroys instance that is made with deploy.yml


**Ansible and Terraform Linter** (ansiblelint.yml and tflint.yml)
  - Runs linter for every push made into the main branch. Workflows is copied from https://github.com/ansible/ansible-lint-action for Ansible Lint and https://github.com/marketplace/actions/setup-tflint for TFlint.
 
    



