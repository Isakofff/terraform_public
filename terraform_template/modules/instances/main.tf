# EC2
resource "aws_instance" "main-server" {
  ami = var.golden_ami
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group]
  subnet_id = var.subnet1
  count = 2

  root_block_device {
    volume_type = "standard"
    volume_size = 30
    delete_on_termination = true
  }

  tags = {
    Name = "terraform-aws-main-server"
  }
}

# decoupling the creation of IP and its assignment
resource "aws_eip_association" "eip_association" {
  instance_id = aws_instance.main-server[0].id
  allocation_id = aws_eip.main-server-ip.id
}

# static IP
resource "aws_eip" "main-server-ip" {
  instance = aws_instance.main-server[0].id

  tags = {
    Name = "terraform-aws-main-server-ip"
  }
}
