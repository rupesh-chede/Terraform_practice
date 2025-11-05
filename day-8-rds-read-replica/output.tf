output "vpc-id" {
    value = aws_vpc.rds-vpc.id
}

output "sub1" {
    value = aws_subnet.sub1.id
}

output "sub2" {
    value = aws_subnet.sub2.id
}

output "subgroup" {
    value = aws_db_subnet_group.rds_sub_group.id
}

output "db_id" {
    value = aws_db_instance.mydb.id
}