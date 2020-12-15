
resource "aws_instance" "web" {
  count = 2
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = var.subnets[count.index]
  vpc_security_group_ids = [var.wordpress_sg_id]
  associate_public_ip_address = true
}