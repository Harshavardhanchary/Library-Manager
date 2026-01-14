variable "project_name" {}
variable "vpc_id" {}
variable "private_subnets" {}
variable "alb_sg_id" {}
variable "target_group_arn" {}

variable "image_url" {}
variable "container_port" {}

variable "cpu" {
  default = "256"
}

variable "memory" {
  default = "512"
}

variable "desired_count" {
  default = 1
}

variable "db_url" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}
