resource "aws_vpc_endpoint" "production_ssm" {
  vpc_id              = aws_vpc.production_vpc.id
  service_name        = "com.amazonaws.eu-west-1.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.production_private_app_1.id,
    aws_subnet.production_private_app_2.id
  ]

  security_group_ids = [
    aws_security_group.production_vpc_endpoints.id
  ]

  tags = {
    Name = "production-ssm-endpoint"
  }
}

resource "aws_vpc_endpoint" "production_ssmmessages" {
  vpc_id              = aws_vpc.production_vpc.id
  service_name        = "com.amazonaws.eu-west-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.production_private_app_1.id,
    aws_subnet.production_private_app_2.id
  ]

  security_group_ids = [
    aws_security_group.production_vpc_endpoints.id
  ]

  tags = {
    Name = "production-ssmmessages-endpoint"
  }
}

resource "aws_vpc_endpoint" "production_secretsmanager" {
  vpc_id              = aws_vpc.production_vpc.id
  service_name        = "com.amazonaws.eu-west-1.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.production_private_app_1.id,
    aws_subnet.production_private_app_2.id
  ]

  security_group_ids = [
    aws_security_group.production_vpc_endpoints.id
  ]

  tags = {
    Name = "production-secretsmanager-endpoint"
  }
}
