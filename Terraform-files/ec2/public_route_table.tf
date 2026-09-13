resource "aws_route_table" "production_public" {
  vpc_id = aws_vpc.production_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.production_igw.id
  }

  tags = {
    Name = "production-public-route-table"
  }
}
