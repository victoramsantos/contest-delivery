
data "aws_api_gateway_rest_api" "rest_api" {
  name = var.border_gateway_name
}
resource "aws_api_gateway_authorizer" "authorizer" {
  name                   = var.authorizer_name
  rest_api_id            = data.aws_api_gateway_rest_api.rest_api.id
  authorizer_uri         = aws_lambda_function.lambda.invoke_arn
  authorizer_credentials = aws_iam_role.invocation_role.arn
}


resource "aws_iam_role" "invocation_role" {
  name = "api_gateway_auth_invocation"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "invocation_policy" {
  name = "default"
  role = aws_iam_role.invocation_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "${aws_lambda_function.lambda.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role" "lambda" {
  name = "lambda_invocation"

  assume_role_policy = <<EOF
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
EOF
}

resource "aws_lambda_function" "lambda" {
  filename = var.lambda_zip_path
  function_name = var.lambda_name
  role = aws_iam_role.invocation_role.arn
  handler = var.lambda_handler
  runtime = var.lambda_runtime

  source_code_hash = filebase64sha256(var.lambda_zip_path)
}