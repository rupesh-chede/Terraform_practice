resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Dev-VPC"
    }
  
}
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "Subnet-1"
    }
}
resource "aws_instance" "name" {
    subnet_id = aws_subnet.name.id
    ami = var.ami
    instance_type = var.ec2-type
    tags = {
      Name = "prod"
    }
  
}
