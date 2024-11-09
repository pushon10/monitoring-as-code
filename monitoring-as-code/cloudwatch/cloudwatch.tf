provider "aws" {
  region = "us-east-1" # Change this to your preferred region
}

# CloudWatch alarm for EC2 instance CPU utilization
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

# Additional alarms can be created similarly for other metrics, but this is just a demo

