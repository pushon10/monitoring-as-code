# ec2.tf
resource "aws_instance", "web" {
    ami = var.ami
    instance_type = var.instance_type

    tags = {
        Name = "Monitoring-EC2"
  }
}

# Security Group for EC2 instance_type
resource "aws_security_group" "web_sg" {
  description = "Allow SSH and HTTP traffic"
  vpc_id = aws_vpc.main.id
}