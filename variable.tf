variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "13.0.0.0/16"
}

variable "subnet01_cidr" {
  default = "13.0.1.0/24"
}

variable "subnet02_cidr" {
  default = "13.0.2.0/24"
}

variable "ingress_22" {
  default = 22
}

variable "ingress_80" {
  default = 80
}

variable "ingress_3389" {
  default = 3389
}

variable "ami_ec2" {
  default = "ami-03657b56516ab7912"
}

variable "instance_type_ec2" {
  default = "t2.micro"
}

variable "key_name_ec2" {
  default = "oregonkeypair"
}
