terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.21.0"
    }
  }
}

locals {
  security_gp_id = 	"sg-07bc081151b162747"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["one", "two"])

  name = "instance-${each.key}"

  instance_type          = var.instance_req
  key_name               = var.key_pair
  monitoring             = true
  vpc_security_group_ids = ["${security_gp_id}"]
  subnet_id              = var.sebnet_ID

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
