# Create VPC
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "dev"
    }
  
}

#Create subnet 1
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "sub-1"
    }
}

#Create subnet 2
resource "aws_subnet" "name1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "sub-2"
    }
}

#Create internet gateway
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
}


#Create route table and edit route
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id

   route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id

   }
}

#Create subnet association 
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.name.id
}

#Create SG
resource "aws_security_group" "name" {
    name = "allow"
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "dev"
    }
      ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress  {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#Servers
resource "aws_instance" "name" {
    ami = var.ami-id
    instance_type = var.ec2-type
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [ aws_security_group.name.id ]
    associate_public_ip_address = true
    tags = {
      Name = "public-ec2"
    }
  
}

resource "aws_instance" "name2" {
  ami = var.ami-id
  instance_type = var.ec2-type
  subnet_id = aws_subnet.name1.id
  vpc_security_group_ids = [ aws_security_group.name.id ]

  
}


#create EIP 

#create nat

#create RT and edit routes

#Route table asscoiation 