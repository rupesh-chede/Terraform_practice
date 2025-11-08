resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.dev.id
    tags = {
      Name = "MyIG"
    } 
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.dev.id
    tags = {
      Name = "Public-RT"
    }
}

resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id 
}

resource "aws_route_table_association" "public_sub_1" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.public_rt.id 
}

resource "aws_route_table_association" "public_2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_eip" "nat_eip" {

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {

allocation_id = aws_eip.nat_eip.id
subnet_id = aws_subnet.public1.id
tags = {
  Name = "nat-GW"
}
  
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route" "private_rt" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
  
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.frontend1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.frontend2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_3" {
  subnet_id      = aws_subnet.backend1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_4" {
  subnet_id      = aws_subnet.backend2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_5" {
  subnet_id      = aws_subnet.rds1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_6" {
  subnet_id      = aws_subnet.rds2.id
  route_table_id = aws_route_table.private_rt.id
}




