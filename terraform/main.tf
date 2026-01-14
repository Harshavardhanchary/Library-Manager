terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# -----------------------------
# VPC MODULE
# -----------------------------
module "vpc" {
  source = "./modules/vpc"

  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}

# -----------------------------
# ALB MODULE
# -----------------------------
module "alb" {
  source = "./modules/alb"

  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.vpc.public_subnet_ids
  container_port      = var.container_port
  health_check_path   = var.health_check_path
}

# -----------------------------
# ECS MODULE
# -----------------------------
module "ecs" {
  source = "./modules/ecs"

  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnet_ids

  alb_sg_id             = module.alb.alb_sg_id
  target_group_arn      = module.alb.target_group_arn

  image_url             = var.image_url
  container_port        = var.container_port

  cpu                   = var.cpu
  memory                = var.memory
  desired_count         = var.desired_count

  db_url                = var.db_url
  db_username           = var.db_username
  db_password           = var.db_password
}

# -----------------------------
# RDS MODULE
# -----------------------------
module "rds" {
  source = "./modules/rds"

  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnet_ids
  app_sg_id        = module.ecs.app_sg_id

  dbname          = var.dbname
  username         = var.username
  password         = var.password

  allocated_storage = var.allocated_storage
  instance_class    = var.instance_class
}

