variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "dbname" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "app_sg_id" {
  description = "ECS application security group ID"
  type        = string
}
