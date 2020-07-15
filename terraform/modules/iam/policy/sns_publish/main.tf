data "aws_iam_policy_document" "sns_publish" {
  statement {
    actions = [
      "sns:Publish"
    ]

    resources = [
      var.topic_arn
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name   = "${var.owner_name}-sns-publish"
  path   = "/"
  policy = data.aws_iam_policy_document.sns_publish.json
}

resource "aws_iam_role_policy_attachment" "policy-attaching" {
  role       = var.role_name
  policy_arn = aws_iam_policy.policy.arn
}