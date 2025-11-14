variable "vpc_cidr" {
    default = "10.0.0.0/16"
    type = string
}

variable "vpc_name" {
    default = "Prod-VPC"
    type = string
}

variable "subnet_1_cidr" {
    default = "10.0.1.0/24"
    type = string
}

variable "subnet_2_cidr" {
    default = "10.0.2.0/24"
    type = string
}

variable "az1" {
    default = "us-east-1a"
    type = string
}

variable "az2" {
    default = "us-east-1b"
    type = string
}

variable "ami_id" {
    default = "ami-0cae6d6fe6048ca2c"
    type = string
}

variable "instance_type" {
    default = "t3.micro"
    type = string
}

variable "server_name" {
    default = "Prod-Server"
    type = string
}