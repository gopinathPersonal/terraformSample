provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

module "vpc" {
  source = "./vpc"
  vpc_cidr = var.vpc_cidr
  subnet01_cidr = var.subnet01_cidr
  subnet02_cidr = var.subnet02_cidr
  ingress_22 = var.ingress_22
  ingress_80 = var.ingress_80
  ingress_3389 = var.ingress_3389

}

module "lb" {
  source = "./lb"
  subnets = [module.vpc.subnet01_id,module.vpc.subnet02_id]
  security_groups = module.vpc.Sec_grp
 
}

module "ec2"{
  source = "./ec2"
  ami_ec2 = var.ami_ec2
  instance_type_ec2 = var.instance_type_ec2
  key_name_ec2 = var.key_name_ec2
  subnet01 = module.vpc.subnet01_id
  security_groups = module.vpc.Sec_grp
  elb = module.lb.LB
}
