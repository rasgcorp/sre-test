provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "networking" {
  source = "./modules/networking"  
}

module "rds-potgres" {
  source = "./modules/rds-pg"
  subnets = [module.networking.subnet_data1_id, module.networking.subnet_data2_id]
  vpc_id = module.networking.vpc_id
  wordpress_rdb_sg_id = module.networking.wordpress_rdb_sg_id
}

module "ec2" {
  source = "./modules/ec2"
  subnets = [module.networking.subnet1_id, module.networking.subnet2_id]
  wordpress_sg_id = module.networking.wordpress_sg_id
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.networking.vpc_id
  subnets = [module.networking.subnet1_id, module.networking.subnet2_id]
  instance_target_ids = module.ec2.instance_target_ids
  wordpress_sg_id = module.networking.wordpress_sg_id  
}

module "route53" {
  source = "./modules/route53"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
}