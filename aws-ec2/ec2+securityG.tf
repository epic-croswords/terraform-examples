terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.26.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  alias = "aws_sou"
}

locals {
  ami_id = "ami-02a2af70a66af6dfb"
  vpc_id = "vpc-0923d55d96fd846ad"
  cidr_block = "172.31.0.0/16"
}


resource "aws_instance" "web01" {
  ami           = "${local.ami_id}"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }

}

module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = "${local.vpc_id}"

  ingress_cidr_blocks      = ["${local.cidr_block}"]
  ingress_rules            = ["https-443-tcp"] 
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090 //NOTE: this are the port range (its not forwarding any port to any port)
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "${local.cidr_block}"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

output "instance_ip_addr" {
  value = aws_instance.web01.public_ip
}