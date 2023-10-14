variable "ec2_count" {
  default = "1"
}
variable "ami-id" {
  default = "ami-0a5ac53f63249fba0"
}
variable "type_instance" {
  default = "t2.micro"
}
variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}

# for Multiple Ecc2 instances 

variable "key_pair" {
    default = "awspractice+epic+keypair"
}
variable "sebnet_ID" {
    default = "subnet-0f77a0fea04a56ddd"
}
variable "instance_req" {
    default = "t2.micro"
}