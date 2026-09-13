resource "aws_nat_gateway" "production_nat" {
  allocation_id = aws_eip.production_nat.id
  subnet_id     = aws_subnet.production_public_1.id

  tags = {
    Name = "production-nat"
  }

  depends_on = [aws_internet_gateway.production_igw]
}
