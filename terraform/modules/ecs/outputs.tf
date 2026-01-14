output "ecs_cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.service.name
}
output "app_sg_id" {
  value = aws_security_group.app_sg_id.id
}
