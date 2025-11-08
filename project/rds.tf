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
    identifier = "my-sql-db"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.mirco"
    allocated_storage = 10

    username = "admin"
    password = "SkyOps123"

    db_subnet_group_name = aws_db_subnet_group.rds_sub_group.id
    skip_final_snapshot = true

    backup_retention_period = 7
    backup_window = "02:00-03:00"

    maintenance_window = "sun:04:00-sun:05:00"
  
}