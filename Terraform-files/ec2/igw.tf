resource "aws_internet_gateway" "production_igw" {
  vpc_id = aws_vpc.production_vpc.id

  tags = {
    Name = "production-igw"
  }
}
