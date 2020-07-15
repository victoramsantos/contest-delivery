data aws_security_group mysql_sg {
  name = var.db_sg_name
}

resource random_password username {
  length = 16
  number = false
  special = false
}

resource "aws_secretsmanager_secret" "db_username_secret" {
  name = "${var.identifier}-username"
}

resource "aws_secretsmanager_secret_version" "username_secret" {
  secret_id     = aws_secretsmanager_secret.db_username_secret.id
  secret_string = random_password.username.result
}

resource random_password password {
  length = 16
  special = false
}

resource "aws_secretsmanager_secret" "db_password_secret" {
  name = "${var.identifier}-password"
}

resource "aws_secretsmanager_secret_version" "password_secret" {
  secret_id     = aws_secretsmanager_secret.db_password_secret.id
  secret_string = random_password.password.result
}

resource "aws_db_instance" "database" {
  allocated_storage = var.allocated_storage
  storage_type = var.storage_type
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  identifier = var.identifier
  username = random_password.username.result
  password = random_password.password.result
  parameter_group_name = var.parameter_group_name
  db_subnet_group_name = var.db_subnet_group_name
  skip_final_snapshot = true
  vpc_security_group_ids = [data.aws_security_group.mysql_sg.id]
}