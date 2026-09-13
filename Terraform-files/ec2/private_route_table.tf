resource "aws_route_table" "production_private_app" {
  vpc_id = aws_vpc.production_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.production_nat.id
  }

  tags = {
    Name = "production-private-app-route-table"
  }
}
