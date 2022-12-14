resource "aws_instance" "node_exporter" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = aws_subnet.private_subnet1.id
  security_groups = [aws_security_group.node_exporter-sg.id]
  user_data       = file("node_exporter.sh")
  tags = {
    Name = "node_exporter"
  }
}