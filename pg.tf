resource "aws_instance" "pg" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet1.id

  security_groups = [aws_security_group.pg-sg.id]
  user_data = file("pg.sh")

  tags = {
    Name = "pg"
  }
}