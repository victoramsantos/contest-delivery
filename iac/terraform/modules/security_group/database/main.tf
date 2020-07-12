data aws_vpc vpc {
  id = var.vpc_id
}

resource "aws_security_group" "mysql_sg" {
  name = var.db_sg_name
  vpc_id = data.aws_vpc.vpc.id

  ingress {
    description = var.db_sg_name
    from_port = var.port
    protocol = "TCP"
    to_port = var.port
    cidr_blocks = [var.cidr]
  }
}