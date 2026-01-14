output "db_endpoint" {
  value = aws_db_instance.db-instance.endpoint
}

output "db_name" {
  value = aws_db_instance.db-instance.db_name
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
