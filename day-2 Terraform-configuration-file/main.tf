resource "aws_vpc" "Dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Dev"
  }
  
}

resource "aws_subnet" "sub-1" {
  vpc_id = aws_vpc.Dev.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Subnet-1"
  }
  
}

resource "aws_instance" "ec2" {
  ami =var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.sub-1.id
  key_name = "test"
  tags = {
    Name = "ec2"
  }
  
}