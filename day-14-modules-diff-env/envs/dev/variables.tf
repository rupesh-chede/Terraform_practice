variable "ami_id" {
    default = "ami-0cae6d6fe6048ca2c"
    type = string
}

variable "instance_type" {
    default = "t3.micro"
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