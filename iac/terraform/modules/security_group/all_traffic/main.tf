data aws_vpc vpc {
  id = var.vpc_id
}

resource "aws_security_group" "all_traffic" {
  name = var.sg_name
  vpc_id = data.aws_vpc.vpc.id

  ingress {
    description = "All Traffic - be care"
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}