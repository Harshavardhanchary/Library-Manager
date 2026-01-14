resource "aws_db_instance" "db-instance" {
  identifier           = "${var.project_name}-db"
  allocated_storage    = var.allocated_storage
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class

  db_name              = var.dbname
  username             = var.username
  password             = var.password

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  storage_type        = var.storage_type

  skip_final_snapshot  = true
  multi_az               = false
  publicly_accessible    = false
}

  
resource "aws_security_group" "rds_sg" {
  name        = "db-security-group"
  description = "Allow database traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [var.app_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name        = "db-subnet-group"
  description = "DB subnet group"
  subnet_ids  = var.private_subnets
}