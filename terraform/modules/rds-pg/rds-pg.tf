resource "aws_db_instance" "wordpress-db" {
  identifier                 = "wordpress-db"
  allocated_storage          = 20
  storage_type               = "gp2"
  engine                     = "postgres"
  engine_version             = "9.6.9"
  instance_class             = "db.t2.micro"
  name                       = "wordpress"
  username                   = "wordpress"
  password                   = "Admin4321"
  db_subnet_group_name       = aws_db_subnet_group.wordpress.id
  vpc_security_group_ids     = [var.wordpress_rdb_sg_id]
  backup_window              = "01:00-01:30"
  auto_minor_version_upgrade = false
}

resource "aws_db_subnet_group" "wordpress" {
  name       = "wordpress-rds"
  subnet_ids = var.subnets

  tags = {
    Name = "wordpress RDS Subnet Group"
  }
}


