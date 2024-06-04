# ---- Global vars
variable "aws_region" {
  default = "us-east-1"
}

variable "project" {}
variable "environment" {}

# --- Variable for EC2
variable "ami" {}
variable "instance_type" {}
