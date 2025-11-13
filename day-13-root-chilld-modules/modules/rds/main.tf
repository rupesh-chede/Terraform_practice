resource "aws_db_subnet_group" "db_subnet_group" {
    name = "db-subnet-group"
    subnet_ids = [ var.subnet_1_id, var.subnet_2_id ]

    tags = {
      Name = "My Subnet Group"
    }
  
}

resource "aws_db_instance" "my_sql" {
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    instance_class = var.instance_class
    db_name = var.db_name
    username = var.db_user
    password = var.db_pass
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    skip_final_snapshot = true

}