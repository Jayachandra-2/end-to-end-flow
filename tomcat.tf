 resource "aws_instance" "tomcat" {
    ami = var.ami
    instance_type = var.instance_type 
    key_name = var.key_name
    subnet_id = aws_subnet.private_subnet1.id
    security_groups = [aws_security_group.tomcat-sg.id]
    user_data = file("tomcat.sh")

    tags = {
    Name = "tomcat"
  }
}