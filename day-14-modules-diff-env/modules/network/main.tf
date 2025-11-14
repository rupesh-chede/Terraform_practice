resource "aws_vpc" "vpc_1" {
    cidr_block =  var.vpc_cidr
    tags = {
      Name = var.vpc_name
    }
}

resource "aws_subnet" "sub_1" {
    vpc_id = aws_vpc.vpc_1.id
    cidr_block = var.sub_1_cidr
    availability_zone = var.az_1
    tags = {
      Name = "Subnet-1"
    }
}

resource "aws_subnet" "sub_2" {
    vpc_id = aws_vpc.vpc_1.id
    cidr_block =  var.su_2_cidr
    availability_zone = var.az_2
    tags = {
      Name = "Subnet-2"
    }
}