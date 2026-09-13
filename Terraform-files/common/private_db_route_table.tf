resource "aws_route_table" "production_private_db" {
  vpc_id = aws_vpc.production_vpc.id

  tags = {
    Name = "production-private-db-route-table"
  }
}
