resource "aws_lb_target_group" "wordpress" {
  name     = "lb-tg-wordpress"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "wordpress" {
  count = 2
  target_group_arn = aws_lb_target_group.wordpress.arn
  target_id        = var.instance_target_ids[count.index]
  port             = 80
}

data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "alb_access_logs" {
  bucket = "wordpress-alb-access-logs"
  acl    = "private"  
  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::wordpress-alb-access-logs/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY  
}

resource "aws_lb" "wordpress" {
  name               = "aws-lb-wordpress"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.wordpress_sg_id]
  subnets            = var.subnets
  access_logs {
    bucket  = aws_s3_bucket.alb_access_logs.bucket
    enabled = true
  }  
}

resource "aws_lb_listener" "wordpress" {
  load_balancer_arn = aws_lb.wordpress.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress.arn
  }
}