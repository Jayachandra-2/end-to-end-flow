resource "aws_instance" "sonarqube" {
  ami           = var.ubuntu_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet1.id

  security_groups = [aws_security_group.sonarqube-sg.id]
  user_data = file("sonarqube.sh")

  tags = {
    Name = "sonarqube"
  }
}