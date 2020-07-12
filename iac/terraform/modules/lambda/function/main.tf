resource "aws_lambda_function" "lambda" {
  filename      = var.lambda_zip_path
  function_name = var.lambda_name
  role          = aws_iam_role.role.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime

  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = var.environment
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