output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet1_id" {
  value = aws_subnet.subnet1.id
}

output "subnet2_id" {
  value = aws_subnet.subnet2.id
}

output "subnet_data1_id" {
  value = aws_subnet.subnet_data1.id
}

output "subnet_data2_id" {
  value = aws_subnet.subnet_data2.id
}

output "wordpress_sg_id" {
  value = aws_security_group.wordpress_sg.id
}

output "wordpress_rdb_sg_id" {
  value = aws_security_group.wordpress_rdb_sg.id
}

