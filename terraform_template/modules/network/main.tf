resource "aws_vpc" "environment1" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "terraform-aws-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  # https://www.terraform.io/docs/configuration/functions/cidrsubnet.html
  cidr_block = cidrsubnet(aws_vpc.environment1.cidr_block, 3, 1)
  # call our VPC by ID
  vpc_id            = aws_vpc.environment1.id
  availability_zone = var.AZs["az1"]
  tags = {
    Name = "terraform-aws-subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  cidr_block        = cidrsubnet(aws_vpc.environment1.cidr_block, 8, 1)
  vpc_id            = aws_vpc.environment1.id
  availability_zone = var.AZs["az2"]
  tags = {
    Name = "terraform-aws-subnet2"
  }
}

resource "aws_security_group" "subnet-security" {
  # 'Security group name' field
  name = "subnet-security"
  description = "Allow all traffic from our VPC and world-wide 80/443"
  vpc_id = aws_vpc.environment1.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    # 0.0.0.0/0 - worldwide
    # ["ip/32", "ip/32"]
    cidr_blocks = [aws_vpc.environment1.cidr_block]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "terraform-aws-SG"
  }
}