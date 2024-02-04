terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4.23.0"
    }
  }
   cloud {
    organization = "kojimenez"
    workspaces {
      name = "tfc-aws-portfolio"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fa377108253bf620"
  instance_type = "t2.micro"
  key_name = "id_rsa"

  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    cicd = "sys1"
  }
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh_access"
  description = "Allow inbound ssh traffic, http, and https"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  tags = {
    Name = "ssh_access"
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "id_rsa"
  public_key = var.pub_key
}
