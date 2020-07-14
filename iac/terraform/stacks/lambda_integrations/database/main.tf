provider "aws" {
  region = "us-east-1"
}

data aws_security_group mysql_sg {
  name = var.mysql_sg_name
}

data aws_security_group all_traffic {
  name = var.all_traffic_sg_name
}

module "lambda_function_with_database" {
  source = "../../../modules/lambda/with_database"

  database_identifier = var.database_identifier
  lambda_handler = var.lambda_handler
  lambda_name = var.lambda_name
  lambda_runtime = var.lambda_runtime
  lambda_zip_path = var.lambda_zip_path
  secret_password_arn = var.secret_password_arn
  secret_username_arn = var.secret_username_arn
  database_name = var.database_name

  sg_ids = [data.aws_security_group.all_traffic.id, data.aws_security_group.mysql_sg.id]
  subnet_ids = var.subnet_ids
}

module "api_integration" {
  source = "../../../modules/api_gateway/integration/cors_mock"

  account_id = var.account_id
  border_gateway_name = var.border_gateway_name
  http_method = var.http_method
  lambda_invoke_arn = module.lambda_function_with_database.lambda_invoke_arn
  lambda_function_name = module.lambda_function_with_database.lambda_name
  region = var.region
  resource = var.resource
  stage_name = var.stage_name
}