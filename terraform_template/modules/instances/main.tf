# EC2
resource "aws_instance" "main-server" {
  ami = var.golden_ami
  instance_type = "t3a.medium"
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group]
  subnet_id = var.subnet1

  root_block_device {
    volume_type = "standard"
    volume_size = 30
    delete_on_termination = true
  }

  tags = {
    Name = "terraform-aws-main-server"
  }
}


# static IP
resource "aws_eip" "main-server-ip" {
  instance = aws_instance.main-server.id

  tags = {
    Name = "terraform-aws-main-server-ip"
  }
}
