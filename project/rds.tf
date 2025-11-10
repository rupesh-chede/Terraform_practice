#rds subnet group
resource "aws_db_subnet_group" "rds_sub_group" {
    name = "rds-subnet-group"
    subnet_ids = [ aws_subnet.rds1.id, aws_subnet.rds2.id ]

    tags = {
      Name = "rds-subnet-group"
    }
}

# ----------------------------- #
# RDS MySQL Database
# ----------------------------- #
resource "aws_db_instance" "mysql" {
    allocated_storage = 10
    db_name = "Dev"
    identifier = "dev-db"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    username = "admin"
    password = "SkyOps123"
    parameter_group_name = "default.mysql8.0"
    db_subnet_group_name = aws_db_subnet_group.rds_sub_group.name
    vpc_security_group_ids = [ aws_security_group.rds_sg.id ]

    backup_retention_period = 7
    backup_window = "02:00-03:00"

    maintenance_window = "sun:04:00-sun:05:00"

    skip_final_snapshot = true
  
}