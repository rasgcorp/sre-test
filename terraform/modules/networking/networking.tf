resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id  
}

resource "aws_subnet" "subnet1" {  
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr1
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone1
}

resource "aws_subnet" "subnet2" {  
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr2
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone2
}

resource "aws_subnet" "subnet_data1" {  
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_data1
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone1
}

resource "aws_subnet" "subnet_data2" {  
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_data2
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone2
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.main.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta_subnet_public1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "rta_subnet_public2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress_sg"
  description = "Permite el trafico de ingreso a las instancias ec2"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "wordpress_rdb_sg" {
  name        = "wordpress_rdb_sg"
  description = "Allow traffic for rds "
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.wordpress_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}