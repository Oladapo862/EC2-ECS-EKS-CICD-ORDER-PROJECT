resource "aws_eip" "production_nat" {
  domain = "vpc"

  tags = {
    Name = "production-nat-eip"
  }
}
