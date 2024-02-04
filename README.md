### Linter Status
[![Ansible Linter](https://github.com/KevJimenez/IaC-for-Automation/actions/workflows/ansiblelint.yml/badge.svg)](https://github.com/KevJimenez/IaC-for-Automation/actions/workflows/ansiblelint.yml)
[![Terraform Linter](https://github.com/KevJimenez/IaC-for-Automation/actions/workflows/tflint.yml/badge.svg)](https://github.com/KevJimenez/IaC-for-Automation/actions/workflows/tflint.yml)


# Automated Virtual Private Server Guide
## Overview
An automated setup of infrastracture with configuration for a web server (uses Amazon EC2 as VPS) using Terraform (IaC) and Ansible (CaC). Can be used to instantly deploy or destroy the web server and the configuration files are checked in to a GitHub repository. Used Github Actions that is run on a local Ubuntu instance for the automation of the whole process. The web server made in this project hosts my personal portfolio site.

## Diagrams:
- IaC-for-Automation

![iac](/images/iac.png)

- Whole CI/CD Pipeline of the Project [(Link to the Hugo Static Repository)](https://github.com/KevJimenez/Hugo-Static)

![whole](/images/whole.png)



