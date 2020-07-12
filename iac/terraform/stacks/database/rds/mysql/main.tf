provider "aws" {
  region = "us-east-1"
}

module "rds_mysql" {
  source = "../../../../modules/rds/mysql"

  db_sg_name = var.db_sg_name
  identifier = var.db_name
  db_subnet_group_name = var.db_subnet_group_name
}