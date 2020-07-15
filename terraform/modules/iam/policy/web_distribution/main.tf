data "aws_iam_policy_document" "web_distribution" {
  statement {
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [var.web_distribution_arn]
    }
    resources = ["${var.s3_arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "web_distribution" {
  bucket = var.s3_id
  policy = data.aws_iam_policy_document.web_distribution.json
}