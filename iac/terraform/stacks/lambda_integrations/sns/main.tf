provider "aws" {
  region = "us-east-1"
}

module "sns_with_sms_subscription" {
  source = "../../../modules/sns/sms_subscription"

  sms_subscription = var.sms_subscription
  sns_name = var.sns_name
}

module "lambda_function" {
  source = "../../../modules/lambda/function"

  lambda_handler = var.lambda_handler
  lambda_name = var.lambda_name
  lambda_runtime = var.lambda_runtime
  lambda_zip_path = var.lambda_zip_path

  environment = {
    SNS_ARN = module.sns_with_sms_subscription.sns_arn
  }
}

module "api_integration" {
  source = "../../../modules/api_gateway/integration/lambda"

  account_id = var.account_id
  border_gateway_name = var.border_gateway_name
  http_method = var.http_method
  lambda_invoke_arn = module.lambda_function.lambda_invoke_arn
  lambda_function_name = module.lambda_function.lambda_name
  region = var.region
  resource = var.resource
  stage_name = var.stage_name
}

module "sns_publish" {
  source = "../../../modules/iam/policy/sns_publish"

  owner_name = var.lambda_name
  role_name = module.lambda_function.lambda_role_name
  topic_arn = module.sns_with_sms_subscription.sns_arn
}

module "log_access" {
  source = "../../../modules/iam/policy/log"

  owner_name = var.lambda_name
  role_name = module.lambda_function.lambda_role_name
}

