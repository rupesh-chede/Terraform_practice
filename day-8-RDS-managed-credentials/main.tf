resource "aws_db_instance" "name" {
    allocated_storage = 10
    identifier = "dev-db"
    db_name = "mydb"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    manage_master_user_password = true
    username = "admin"
    parameter_group_name = "mysql8.0"
    backup_retention_period = 7
    backup_window = "02:00-03:00"
    maintenance_window = "sun:04:00-sun:05:00"
    skip_final_snapshot = true
    db_subnet_group_name = aws_db_subnet_group.name.id
  
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "RDS-VPC"
    }
}

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "Sub-1"
    }
  
}

resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "Sub-2"
    }
}

resource "aws_db_subnet_group" "name" {
    name = "mysubnetgroup"
    subnet_ids = [ aws_subnet.subnet-1.id , aws_subnet.subnet-2.id ]
    tags = {
      Name = "Subnet-group"
    }
  
}