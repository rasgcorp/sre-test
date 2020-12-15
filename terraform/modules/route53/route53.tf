data "aws_route53_zone" "wordpress" {
  name         = "rsgconsole.net."
  private_zone = false
}

resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.wordpress.zone_id
  name    = data.aws_route53_zone.wordpress.name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = false
  }
}
