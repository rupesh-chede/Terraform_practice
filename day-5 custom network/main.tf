resource "aws_vpc" "Dev-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Dev-VPC"
  } 
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.Dev-VPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public-sub"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.Dev-VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Private-sub"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.Dev-VPC.id
  tags = {
    Name = "Dev-ig"
  }
}

resource "aws_route_table" "route-table-1" {
    vpc_id = aws_vpc.Dev-VPC.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
   }

   tags = {
     Name = "IG"
   }
}

resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.route-table-1.id
}

resource "aws_security_group" "sg" {
  name = "allow"
  vpc_id = aws_vpc.Dev-VPC.id
  tags = {
    Name = "SG"
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_instance" "public-ec2" {
  subnet_id = aws_subnet.public.id
  ami = var.ami-id
  instance_type = var.ec2-type
  vpc_security_group_ids = [ aws_security_group.sg.id ]
  associate_public_ip_address = true
  tags = {
    Name = "Public-Server"
  }
}

resource "aws_instance" "private-ec2" {
  subnet_id = aws_subnet.private.id
  ami = var.ami-id
  instance_type = var.ec2-type
  vpc_security_group_ids = [ aws_security_group.sg.id ]
  tags = {
    Name = "Private-server"
  }
}

resource "aws_eip" "my_elastic_ip" {
  tags = {
    Name = "MyEIP"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.public.id
  allocation_id = aws_eip.my_elastic_ip.id
  tags = {
    Name = "Nat-Gatway"
  }
}

resource "aws_route_table" "pvt-rt" {
  vpc_id = aws_vpc.Dev-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "name1" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.pvt-rt.id
  
}