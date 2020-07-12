data "aws_vpc_endpoint_service" "secret_manager" {
  service = "secretsmanager"
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = var.vpc_id
  service_name      = data.aws_vpc_endpoint_service.secret_manager.service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = var.sg_ids
  subnet_ids = var.subnet_ids

  private_dns_enabled = true
}