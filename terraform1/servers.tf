resource "aws_instance" "main-server" {
  ami = var.golden-ami
  instance_type = "t3a.medium"
  vpc_security_group_ids = [aws_security_group.subnet-security.id]
  subnet_id = aws_subnet.subnet2.id

  root_block_device {
    volume_type = "standard"
    volume_size = 30
    delete_on_termination = true
  }

  tags = {
    Name = "terraform-aws-main-server"
  }
}