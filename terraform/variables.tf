variable "project_name" {
  default = "library-manager"
}

variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
    default = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default = [ "ap-south-1a", "ap-south-1b" ]
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "db_password" {
  type      = string
  sensitive = true
  default = "Userpassword"
}
variable "db_username" {
  type    = string
  default = "dbuser"
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "cpu" {
  default = 512
}

variable "memory" {
  default = 1024
}

variable "desired_count" {
  default = 2
}
variable "container_port" {
  default = 8080
}
variable "image_url" {
  description = "Docker image URI for Library Manager ECS task"
  type        = string
  default     = "public.ecr.aws/k3i9e2b8/library-manager:latest"
}

variable "health_check_path" {
  default = "/Homepage.jsp"
}

variable "dbname" {
  default = "librarydb"
}

variable "db_url" {
  description = "JDBC URL for RDS database"
  default     = "jdbc:mysql://library-manager-db.cv0ws8ukgfud.ap-south-1.rds.amazonaws.com:3306/librarydb?connectTimeout=30000&useSSL=false&allowPublicKeyRetrieval=true"
}

variable "allocated_storage" {
  default = 30
}
variable "instance_class" {
  default = "db.t3.micro"
}
variable "username" {
  default = "dbuser"
}
variable "password" {
  default = "Userpassword"
}

