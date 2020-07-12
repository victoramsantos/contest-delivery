resource "aws_sns_topic" "topic" {
  name = var.sns_name
}

resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "sms"
  endpoint  = var.sms_subscription
}