resource "aws_vpc" "dev" {
    cidr_block = var.cidr_block
}

resource "aws_subnet" "sub_1" {
    cidr_block = var.subnet_1_cidr
    vpc_id = aws_vpc.dev.id
    availability_zone = var.az1
}

resource "aws_subnet" "sub_2" {
    vpc_id = aws_vpc.dev.id
    cidr_block = var.subnet_2_cidr
    availability_zone = var.az2
}

output "subnet_1_id" {
    value = "${aws_subnet.sub_1.id}"
  
}