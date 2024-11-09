# SNS topic for CloudWatch alarms
resource "aws_sns_topic" "alerts" {
  name = "ec2-cpu-alerts"
}

# SNS topic subscription to email
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}