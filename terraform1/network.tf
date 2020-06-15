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

# allow all traffic from our VPC
resource "aws_security_group" "subnet-security" {
  vpc_id = aws_vpc.environment1.id
  ingress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = [aws_vpc.environment1.cidr_block]
  }
  tags = {
    Name = "terraform-aws-SG"
  }
}