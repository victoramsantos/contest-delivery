provider "aws" {
  region = "us-east-1"
}

module "api_lambda_integration" {
  source = "../../../modules/lambda/invoked_by_api_gateway/without_database"
  account_id = var.account_id
  border_gateway_name = var.border_gateway_name
  http_method = var.http_method
  lambda_handler = var.lambda_handler
  lambda_name = var.lambda_name
  lambda_runtime = var.lambda_runtime
  lambda_zip_path = var.lambda_zip_path
  region = var.region
  resource = var.resource
  stage_name = var.stage_name
}