output "alb_dns_name" {
  value = aws_lb.wordpress.dns_name
}

output "alb_zone_id" {
  value = aws_lb.wordpress.zone_id
}