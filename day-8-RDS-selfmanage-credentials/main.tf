resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Dev"
    }
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "Sub-1"
    }
}

resource "aws_subnet" "name1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "Sub-2"
    }

}

resource "aws_db_instance" "defoult" {
    allocated_storage = 10
    db_name = "Dev"
    identifier = "dev-db"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    username = "admin"
    password = "SkyOps123"
    parameter_group_name = "default.mysql8.0"
    db_subnet_group_name = aws_db_subnet_group.name.id

    backup_retention_period = 7
    backup_window = "02:00-03:00"

    maintenance_window = "sun:04:00-sun:05:00"

    skip_final_snapshot = true
  
}


resource "aws_db_subnet_group" "name" {
    name = "subgroup"
    subnet_ids = [ aws_subnet.name.id , aws_subnet.name1.id ]
    tags = {
      Name = "MySubnetGroup"
    }
  
}