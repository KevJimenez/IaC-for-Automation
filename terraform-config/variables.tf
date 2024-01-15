variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "testsample"
}

variable "cf_email" {
  description = "cloudflare email"
  type = string
}

variable "cf_api" {
  description = "cloudflare api key"
  type = string
}

variable "ec2_ip" {
  description = "ec2 instance ip"
  type = string
}