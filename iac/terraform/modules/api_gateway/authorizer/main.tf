data "aws_api_gateway_rest_api" "rest_api" {
  name = var.border_gateway_name
}

data "aws_lambda_function" "lambda_authorizer" {
  function_name = var.lambda_name
}

resource "aws_api_gateway_authorizer" "authorizer" {
  name                   = var.authorizer_name
  rest_api_id            = data.aws_api_gateway_rest_api.rest_api.id
  authorizer_uri         = data.aws_lambda_function.lambda_authorizer.invoke_arn
  authorizer_credentials = data.aws_iam_role.invocation_role.arn
}

data "aws_iam_role" "invocation_role" {
  name = "api_gateway_auth_invocation"
}

resource "aws_iam_role_policy" "invocation_policy" {
  name = "${var.lambda_name}-invocation_policy"
  role = data.aws_iam_role.invocation_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "${data.aws_lambda_function.lambda_authorizer.arn}"
    }
  ]
}
EOF
}