# -----------------------------
# VPC
# -----------------------------
resource "aws_vpc" "library_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# -----------------------------
# Internet Gateway
# -----------------------------
resource "aws_internet_gateway" "lms_igw" {
  vpc_id = aws_vpc.library_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# -----------------------------
# Public Subnets
# -----------------------------
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.library_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index}"
  }
}

# -----------------------------
# Private Subnets
# -----------------------------
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.library_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index}"
  }
}

# -----------------------------
# Elastic IP for NAT
# -----------------------------
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

# -----------------------------
# NAT Gateway (in PUBLIC subnet)
# -----------------------------
resource "aws_nat_gateway" "lms_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.lms_igw]
  tags = {
    Name = "${var.project_name}-nat-gateway"
  }
}

# -----------------------------
# Public Route Table
# -----------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.library_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lms_igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# -----------------------------
# Public Route Table Associations
# -----------------------------
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# -----------------------------
# Private Route Table
# -----------------------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.library_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lms_nat.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# -----------------------------
# Private Route Table Associations
# -----------------------------
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
