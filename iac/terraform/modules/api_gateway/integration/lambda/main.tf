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
  type = "LAMBDA"
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


resource "aws_api_gateway_method" "method_options" {
  rest_api_id = data.aws_api_gateway_rest_api.border_gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

# Integrations
resource "aws_api_gateway_integration" "integration_request_options" {
  rest_api_id = data.aws_api_gateway_rest_api.border_gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method_options.http_method
  integration_http_method = "OPTIONS"
  type = "MOCK"
  request_templates = {
    "application/json" = "{ \"statusCode\": 200 }"
  }
}

resource "aws_api_gateway_deployment" "deployment_options" {
  depends_on = [aws_api_gateway_integration.integration_request_options]
  rest_api_id = data.aws_api_gateway_rest_api.border_gateway.id
  stage_name = var.stage_name
}
# aws_api_gateway_integration_response._
resource "aws_api_gateway_integration_response" "_" {
  rest_api_id = data.aws_api_gateway_rest_api.border_gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method_options.http_method
  status_code = 200

  response_parameters = local.integration_response_parameters

  depends_on = [
    aws_api_gateway_integration.integration_request_options,
    aws_api_gateway_method_response.options_response,
  ]
}

resource "aws_api_gateway_method_response" "options_response" {
  rest_api_id = data.aws_api_gateway_rest_api.border_gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method_options.http_method
  status_code = 200

  response_parameters = local.method_response_parameters

  response_models = {
    "application/json" = "Empty"
  }

  depends_on = [
    aws_api_gateway_method.method_options,
  ]
}

locals {
  headers = map(
  "Access-Control-Allow-Headers", "'${join(",", var.allow_headers)}'",
  "Access-Control-Allow-Methods", "'${join(",", var.allow_methods)}'",
  "Access-Control-Allow-Origin", "'*'"
  )

  # Pick non-empty header values
  header_values = compact(values(local.headers))

  # Pick names that from non-empty header values
  header_names = matchkeys(
  keys(local.headers),
  values(local.headers),
  local.header_values
  )

  # Parameter names for method and integration responses
  parameter_names = formatlist("method.response.header.%s", local.header_names)

  # Map parameter list to "true" values
  true_list = split("|",
  replace(join("|", local.parameter_names), "/[^|]+/", "true")
  )

  # Integration response parameters
  integration_response_parameters = zipmap(
  local.parameter_names,
  local.header_values
  )

  # Method response parameters
  method_response_parameters = zipmap(
  local.parameter_names,
  local.true_list
  )
}