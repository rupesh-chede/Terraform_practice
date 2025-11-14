variable "ami_id" {
    default = "ami-0c55b159cbfafe1f0"
    type = string
}

variable "instance_type" {
    default = "t3.mirco"
    type = string
}

variable "server_name" {
    default = "Dev-Server"
    type = string
}

variable "vpc_name" {
    default = "Dev-VPC"
    type = string
}