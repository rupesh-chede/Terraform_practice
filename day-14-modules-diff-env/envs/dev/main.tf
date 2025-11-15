provider "aws" {}

module "network" {
    source = "../../modules/network"
    vpc_cidr = "10.0.0.0/16"
    sub_1_cidr = "10.0.1.0/24"
    su_2_cidr = "10.0.2.0/24"
    az_1 = "us-east-1a"
    az_2 = "us-east-1b"
    vpc_name = var.vpc_name
  
}

module "server" {
    source = "../../modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    subnet_1_id = module.network.subnet_1_id
    server_name = var.server_name
  
}

module "rds" {
    source = "../../modules/rds"
    sub_1_id = module.network.subnet_1_id
    sub_2_id = module.network.subnet_2_id
    instance_class = "db.t3.mirco"
    db_name = "Dev-RDS"
    db_user = "admin"
    db_pass = "SkyOps123"

  
}