# main.tf

# Provider Configuration
provider "aws" {
  region = var.aws_region
}

# EC2 Instance Resource
resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "Monitoring-EC2"
  }
}

# Security Group Resource
resource "aws_security_group" "web_sg" {
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.main.id
}

# CloudWatch Alarm for EC2 High CPU
resource "aws_cloudwatch_metric_alarm" "ec2_high_cpu" {
  alarm_name          = "EC2HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This alarm monitors the CPU utilization of the EC2 instance."
  dimensions = {
    InstanceId = aws_instance.my_ec2.id
  }
  alarm_actions = [aws_sns_topic.alerts.arn]
}

# SNS Topic for Alerts
resource "aws_sns_topic" "alerts" {
  name = "ec2-cpu-alerts"
}

# SNS Topic Subscription (Email Alert)
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
