variable "project_name" {}
variable "vpc_id" {}
variable "public_subnets" {}
variable "container_port" {
  default = 8080
}
variable "health_check_path" {
  default = "/Homepage.jsp"
}
