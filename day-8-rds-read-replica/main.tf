resource "aws_vpc" "rds-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "rds-vpc"
    }
}

resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.rds-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "Subnet-1"
    }
}

resource "aws_subnet" "sub2" {
    vpc_id = aws_vpc.rds-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "Subnet-2"
    }
}


resource "aws_db_subnet_group" "rds_sub_group" {
    name = "mysubnetgroup"
    description = "RDS Subnet Group"
    subnet_ids = [ aws_subnet.sub1.id , aws_subnet.sub2.id ]
}


resource "aws_security_group" "rds_sg" {
    vpc_id = aws_vpc.rds-vpc.id
    name = "Rds-Sg"
    description = "Allow Mysql access"

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_db_instance" "mydb" {
    identifier = "mydbterraform"
    engine = "mysql"
    engine_version = "8.0"
    allocated_storage = 10
    instance_class = "db.t3.micro"
    username = "admin"
    password = "SkyOps123"
    db_subnet_group_name = aws_db_subnet_group.rds_sub_group.id
    vpc_security_group_ids = [ aws_security_group.rds_sg.id ]
    skip_final_snapshot = true
}



