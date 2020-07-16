provider "aws" {
  region = "us-east-1"
}

module "border_api_gateway" {
  source = "../../modules/api_gateway/regional"

  api_gtw_name = var.api_gtw_name
}

module lambda_authorizer {
  source = "../../modules/lambda/function"

  lambda_handler = var.lambda_handler
  lambda_name = var.lambda_name
  lambda_runtime = var.lambda_runtime
  lambda_zip_path = var.lambda_zip_path
}

resource "aws_iam_role" "invocation_role" {
  name = "api_gateway_auth_invocation"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
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

module "all_traffic_security_group_jumpbox" {
  source = "../../modules/security_group/all_traffic"

  sg_name = var.jumpbox_prefix
  vpc_id = var.vpc_id
}

module jumpbox_lc {
  source = "../../modules/ec2/launch_configuration"

  instance_type = var.jumpbox_instance_type
  key_name = var.key_name
  name_prefix = var.jumpbox_prefix
  security_groups = [module.all_traffic_security_group_jumpbox.sg_id]
}

module jumpbox_ag {
  source = "../../modules/ec2/autoscaling_group"
  launch_configuration_name = module.jumpbox_lc.lc_name
  name_prefix = var.jumpbox_prefix
  vpc_zone_identifier = var.jumpbox_subnets
}
