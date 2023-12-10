terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.30.0"
    }
  }
}


provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

#data soruce to fetch info from aws

data "aws_vpc" "main" {
  id = "vpc-0923d55d96fd846ad"
}

#fetch user-data source from userdata.yaml file

data "template_file" "user_data" {
    template = file("./userdata.yml")
}

#security group for aws instance
resource "aws_security_group" "allow_traffic" {
  name        = "SG-for-ec2"
  description = "Allow SSH,HTTP inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress = [
    {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = true
    }
  ,{
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["103.207.8.81/32"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = true
}]


  egress = [
   {
    description      = "all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids = []
    security_groups = []
    self = true
   }
  ]
}

#key pair for ec2 

resource "aws_key_pair" "key-pair" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDElALxAT1Y9Yod+WoXIDqaPeg2zLC4SRlZxpctHXJ6gn6Ysz2v44o2O9WaUV7wydWpF/mF5rySclOZvvBZHwmILvWKdPgAEYC7j03KQ3yIvvHDORb7h1V17Xe96SS5ejclnEWZkM64iKeTVcXzhuUmrW+OnC2HTr1HKdPV6ZX0nAYfw2jAIScH8K8ZUyOgjsaXtWNMEggT9v/xKsc2feN1fICw+0Ke1XbmwCiOfuBoFjC/Jl278eNPsyfuB0o6+ZDKjLDiX7ruY7C7KPeAqsEGrIBHRYEiD93EBY/0c3OKrTtF89Mgee/Y1+bVEa8QJOIBKyyB5dzcu4LnNfpmlD0hB2aqc+u2Gvly5Vi+KyscXNW3XIvp8shTRcbfaoZ5Q+FLA0Ka57RabxuoeFCglc2upxp2ss5vG/t0/OsbOujjKMFr56eL6SKNjPtm6GQ+5FDq0zSz3zlP++zCm3BgVBZpGRXR34F7qKiXC1lv1+yVm+CVuV0js0GiNPK+D2p7p9U= root@LAPTOP-IFDCIAFG"
}


#creating EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-02a2af70a66af6dfb"
  instance_type = "t2.micro"
    key_name = "${aws_key_pair.key-pair.key_name}"
    vpc_security_group_ids = [aws_security_group.allow_traffic.id]
    user_data = data.template_file.user_data.rendered
}

output "public_ip" {
  value       = aws_instance.web.public_ip
  sensitive   = false
  description = "public ip of ec2 instance"
}
