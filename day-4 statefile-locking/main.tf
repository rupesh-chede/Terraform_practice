resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "dev"
    }
  
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "sub-1"
    }
  
}

resource "aws_instance" "name" {
    subnet_id = aws_subnet.name.id
    ami = var.ami-id
    instance_type = var.ec2-type
    tags = {
      Name = "ec2"
    }
  
}