resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.public_subnet1.id

  security_groups = [aws_security_group.bastion-sg.id]
  tags = {
    Name = "bastion"
  }
}