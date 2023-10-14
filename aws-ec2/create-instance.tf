terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}
    provider "aws" {
    region = "ap-south-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

resource "aws_instance" "web" {
  count   = var.ec2_count
  ami           = var.ami-id
  instance_type = var.instance_type
  user_data = "yum update -y"

  tags = {
    Name = "HelloWorld"
  }
}
