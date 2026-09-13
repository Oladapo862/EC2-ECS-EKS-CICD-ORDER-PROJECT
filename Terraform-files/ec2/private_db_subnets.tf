resource "aws_subnet" "production_private_db_1" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "production-private-db-subnet-1"
  }
}

resource "aws_subnet" "production_private_db_2" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "production-private-db-subnet-2"
  }
}
