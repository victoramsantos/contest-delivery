data "aws_db_instance" "database" {
  db_instance_identifier = var.database_identifier
}

resource "aws_lambda_function" "lambda" {
  filename = var.lambda_zip_path
  function_name = var.lambda_name
  role = aws_iam_role.role.arn
  handler = var.lambda_handler
  runtime = var.lambda_runtime

  source_code_hash = filebase64sha256(var.lambda_zip_path)

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.sg_ids
  }

  environment {
    variables = {
      DATABASE_ADDRESS = data.aws_db_instance.database.address,
      DATABASE_NAME = var.database_name
    }
  }
}

# IAM
resource "aws_iam_role" "role" {
  name = "${var.lambda_name}-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

module "database_policy_access" {
  source = "../../iam/policy/rds_secret_manager"

  owner_name = var.lambda_name
  role_name = aws_iam_role.role.name
  secret_password_arn = var.secret_password_arn
  secret_username_arn = var.secret_username_arn
}

module "vpc_access_policy" {
  source = "../../iam/policy/vpc_access"

  owner_name = var.lambda_name
  role_name = aws_iam_role.role.name
}