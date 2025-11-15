resource "aws_db_subnet_group" "sub_grp" {
    name = "subnet-group"
    subnet_ids = [ var.sub_1_id, var.sub_2_id ]
  
}

resource "aws_db_instance" "rds" {
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    instance_class = var.instance_class
    db_name = var.db_name
    username = var.db_user
    password = var.db_pass
    db_subnet_group_name = aws_db_subnet_group.sub_grp.name
    skip_final_snapshot = true

  
}