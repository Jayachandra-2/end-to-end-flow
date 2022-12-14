resource "aws_instance" "jenkins" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet1.id

  security_groups = [aws_security_group.jenkins-sg.id]
  user_data = file("jenkins.sh")

  tags = {
    Name = "jenkins"
  }
}