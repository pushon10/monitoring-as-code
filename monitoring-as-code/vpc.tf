# vpc.tf

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }

}

# Public Subnet in Availability Zone 1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "public_subnet_az1"
  }

}

# Public Subnet in Availability Zone 2
resource "aws_subnet" "public_subnet_az2" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "${var.aws_region}b"

    tags = {
    Name = "public_subnet_az2"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Create a route table
resource "aws_route_table" "public_rt" {
    vpc_id                  = aws_vpc.main.id

    tags = {
      Name = "public-rt"
    }
}

# Add a route to the internet gateway
resource "aws_route" "public_route" {
    route_table_id         = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.main_igw.id

}

# Associate the route table with Public Subnet in Availability Zone 1
resource "aws_route_table_association" "public_rt_assoc_az1" {
    subnet_id      = aws_subnet.public_subnet_az1.id
    route_table_id = aws_route_table.public_rt.id
}

# Associate the route table with Public Subnet in Availability Zone 2
resource "aws_route_table_association" "public_rt_assoc_az2" {
    subnet_id      = aws_subnet.public_subnet_az2.id
    route_table_id = aws_route_table.public_rt.id
}