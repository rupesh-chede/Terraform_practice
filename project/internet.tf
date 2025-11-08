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

resource "aws_route_table_association" "public_rt_assoc" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.public_rt.id
  
}
