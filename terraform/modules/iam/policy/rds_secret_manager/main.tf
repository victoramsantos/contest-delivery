data "aws_iam_policy_document" "GetSecretValue" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue"
    ]

    resources = [
      var.secret_username_arn,
      var.secret_password_arn
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name   = "${var.owner_name}-rds-secret-manager"
  path   = "/"
  policy = data.aws_iam_policy_document.GetSecretValue.json
}

resource "aws_iam_role_policy_attachment" "policy-attaching" {
  role       = var.role_name
  policy_arn = aws_iam_policy.policy.arn
}