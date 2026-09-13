resource "aws_subnet" "production_private_app_1" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "production-private-subnet-1"
  }
}

resource "aws_subnet" "production_private_app_2" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "production-private-subnet-2"
  }
}
