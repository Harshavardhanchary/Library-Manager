output "vpc_id" {
  value = module.vpc.vpc_id
}
output "database_endpoint" {
  value = module.rds.db_endpoint
}
output "load_balancer_dns" {
  value = module.alb.alb_dns_name
}