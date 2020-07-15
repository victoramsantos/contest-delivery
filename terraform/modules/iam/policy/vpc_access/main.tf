data "aws_iam_policy_document" "vpc_access" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "policy" {
  name   = "${var.owner_name}-vpc-access"
  path   = "/"
  policy = data.aws_iam_policy_document.vpc_access.json
}

resource "aws_iam_role_policy_attachment" "policy-attaching" {
  role       = var.role_name
  policy_arn = aws_iam_policy.policy.arn
}