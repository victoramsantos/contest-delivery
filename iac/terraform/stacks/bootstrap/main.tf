provider "aws" {
  region = "us-east-1"
}

module "border_api_gateway" {
  source = "../../modules/api_gateway/regional"

  api_gtw_name = var.api_gtw_name
}

module "mysql_security_group" {
  source = "../../modules/security_group/database"

  cidr = var.db_sg_cidr
  db_sg_name = var.mysql_sg_name
  port = var.mysql_port
  vpc_id = var.vpc_id
}

module db_subnet_group {
  source = "../../modules/rds/subnet_group"

  db_subnet_group_name = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
}

module "all_traffic_security_group" {
  source = "../../modules/security_group/all_traffic"

  sg_name = var.all_traffic_sg_name
  vpc_id = var.vpc_id
}

module vpc_endpoint_secret_manager {
  source = "../../modules/vpc/endpoint/secret_manager"

  subnet_ids = var.subnet_ids
  sg_ids = [module.all_traffic_security_group.sg_id]
  vpc_id = var.vpc_id
}