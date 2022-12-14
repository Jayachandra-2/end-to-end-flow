resource "aws_instance" "nexus" {
  ami           = var.ami
  instance_type = var.medium_instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet1.id

  security_groups = [aws_security_group.nexus-sg.id]
  user_data = file("nexus.sh")

  tags = {
    Name = "nexus"
  }
}