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
    access_key = "***********"
    secret_key = "***********"
}

resource "aws_instance" "web" {
  count   = "1"
  ami           = "ami-067c21fb1979f0b27"
  instance_type = "t2.micro"
  user_data = "yum update -y"

  tags = {
    Name = "HelloWorld"
  }
}
