data "aws_api_gateway_rest_api" "border_gateway" {
  name = var.border_gateway_name
}

resource "aws_api_gateway_resource" "resource" {
  path_part = var.resource
  parent_id = data.aws_api_gateway_rest_api.border_gateway.root_resource_id
  rest_api_id = data.aws_api_gateway_rest_api.border_gateway.id
}

resource "aws_api_gateway_method" "method" {
  rest_api_id = data.aws_api_gateway_rest_api.border_gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = var.http_method
  authorization = "NONE"
}

# Integrations
resource "aws_api_gateway_integration" "integration_request" {
  rest_api_id = data.aws_api_gateway_rest_api.border_gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  integration_http_method = var.http_method
  type = "AWS_PROXY"
  uri = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.integration_request]
  rest_api_id = data.aws_api_gateway_rest_api.border_gateway.id
  stage_name = var.stage_name
}

# Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${data.aws_api_gateway_rest_api.border_gateway.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}