resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"
}
resource "aws_subnet" "public_subnet2" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2b"
}
resource "aws_subnet" "public_subnet3" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2c"
}

resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-2b"
}

resource "aws_subnet" "private_subnet3" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-2c"
}

resource "aws_subnet" "data_private_subnet1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_subnet" "data_private_subnet2" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "us-east-2b"
}

resource "aws_subnet" "data_private_subnet3" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.8.0/24"
  availability_zone = "us-east-2c"
}