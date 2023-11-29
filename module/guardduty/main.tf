resource "aws_sns_topic" "main" {
  name = var.name-sns
  fifo_topic = var.fifo
  content_based_deduplication = var.deduplication 
  tags = {
    "environment"  = "Dev"
  }
}

resource "aws_sns_topic_subscription" "name" {
  topic_arn = aws_sns_topic.main.arn
  protocol = "email"
  endpoint = var.email-notification
}

#Creation of Cloudwatch event rule
resource "aws_cloudwatch_event_rule" "gd-cw-alert-rule" {
  name        = var.event_name
  description = var.description
  is_enabled  = var.enabled

  event_pattern = <<EOF
{
  "source": ["aws.guardduty"],
  "region": ["eu-west-3"],
  "detail-type": ["GuardDuty Finding"],
  "detail": {
    "severity": [6, 6.0, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9, 7, 7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9, 8, 8.0, 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9]
  }
}
EOF
}

#Creation of Cloudwatch event target to SNS
resource "aws_cloudwatch_event_target" "sns-guardduty" {
  rule        = aws_cloudwatch_event_rule.gd-cw-alert-rule.name
  arn         = aws_sns_topic.main.arn 
  target_id   = var.target_id 
  depends_on  = [aws_cloudwatch_event_rule.gd-cw-alert-rule]
} 