variable "instance_ami" {
  default = "ami-0a59470382f925eca"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnets" {}

variable "wordpress_sg_id" {}