resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Day-2"
    }
  
}
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "Subnet1"
    }
  
}
resource "aws_instance" "temp" {
    ami = "ami-07860a2d7eb515d9a"
    subnet_id = aws_subnet.name.id
    instance_type = "t3.micro"
  
}