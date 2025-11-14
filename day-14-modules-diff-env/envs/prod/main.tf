provider "aws" {}

module "network" {
    source = "../../modules/network"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    sub_1_cidr = var.subnet_1_cidr
    su_2_cidr = var.subnet_2_cidr
    az_1 = var.az1
    az_2 = var.az2
}

module "server" {
    source = "../../modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    subnet_1_id = module.network.subnet_1_id
    server_name = var.server_name
    
}