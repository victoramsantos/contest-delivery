data "aws_api_gateway_rest_api" "rest_api" {
  name = var.border_gateway_name
}

resource "aws_api_gateway_resource" "rest_api_resource" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  parent_id = data.aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part = var.resource
}

resource "aws_api_gateway_method" "opt" {
  rest_api_id   = data.aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.rest_api_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "opt" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resource.id
  http_method = aws_api_gateway_method.opt.http_method
  type = "MOCK"

  request_templates = {
    "application/json" = <<EOF
{"statusCode": 200}
EOF
  }
}

resource "aws_api_gateway_integration_response" "opt" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resource.id
  http_method = aws_api_gateway_method.opt.http_method
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'"
  }
  response_templates = {
    "application/json" = "Empty"
  }
  depends_on = [aws_api_gateway_integration.opt, aws_api_gateway_method_response.opt]
}

resource "aws_api_gateway_method_response" "opt" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resource.id
  http_method = aws_api_gateway_method.opt.http_method
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [aws_api_gateway_method.opt]
}

resource "aws_api_gateway_method" "app_api_gateway_method" {
  rest_api_id      = data.aws_api_gateway_rest_api.rest_api.id
  resource_id      = aws_api_gateway_resource.rest_api_resource.id
  http_method      = var.http_method
  authorization    = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_method_response" "app_cors_method_response_200" {
  rest_api_id   = data.aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.rest_api_resource.id
  http_method   = aws_api_gateway_method.app_api_gateway_method.http_method
  status_code   = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  depends_on = [aws_api_gateway_method.app_api_gateway_method]
}

resource "aws_api_gateway_integration" "app_api_gateway_integration" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_method.app_api_gateway_method.resource_id
  http_method = aws_api_gateway_method.app_api_gateway_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri = var.lambda_invoke_arn
  depends_on    = [
    aws_api_gateway_method.app_api_gateway_method
  ]
}

resource "aws_api_gateway_integration_response" "app_api_gateway_integration_response" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resource.id
  http_method = aws_api_gateway_method.app_api_gateway_method.http_method
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.app_api_gateway_integration,
    aws_api_gateway_method_response.app_cors_method_response_200,
  ]
}

resource "aws_api_gateway_deployment" "app_api_gateway_deployment" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  stage_name  = var.stage_name
  depends_on = [
    aws_api_gateway_integration_response.app_api_gateway_integration_response,
    aws_api_gateway_integration_response.opt
  ]
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${data.aws_api_gateway_rest_api.rest_api.id}/*/${var.http_method}${aws_api_gateway_resource.rest_api_resource.path}"
}
