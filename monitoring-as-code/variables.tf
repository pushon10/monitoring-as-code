# variables.tf

# AWS region to deploy the resources
variable "aws_region" {
description = "The AWS region where the resources will manifest"
default = "us-east-1"
}

# EC2 Instance Type
variable "instance_type" {
    description = "The EC2 instance type to be launched"
    default = "t2.micro"
}

# AMI ID for the EC2 Instance
variable "ami" {
    description = "The Amazon Machine Image (AMI) ID for the EC2 instance"
    default     = "ami-0dcdf38b69b57740e"  # Update with your preferred AMI ID
}

# Email address for SNS notifications
variable "alert_email" {
    description = "Email address to receive CloudWatch alarm notifications"
    type        = string
    default     = "pushon10@googlemail.com"  # Your email address
}








