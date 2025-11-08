resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Dev"
    }
}

resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "Public-1"
    }
}

resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.2.0/24"
    tags = {
      Name = "Public-2"
    }
}

resource "aws_subnet" "frontend1" {
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.3.0/24"
    tags = {
      Name = "Frontend-1"
    }
}

resource "aws_subnet" "frontend2" {
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.4.0/24"
    tags = {
      Name = "Frontend-2"
    }
}

resource "aws_subnet" "backend1" {
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.5.0/24"
    tags = {
      Name = "Backend-1"
    }
}

resource "aws_subnet" "backend2" {
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.6.0/24"
    tags = {
      Name = "Backend-2"
    }
}

resource "aws_subnet" "rds1" {
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.7.0/24"
    tags = {
      Name = "RDS-1"
    }
}

resource "aws_subnet" "rds2" {
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.8.0/24"
    tags = {
      Name = "RDS-2"
    }
}

