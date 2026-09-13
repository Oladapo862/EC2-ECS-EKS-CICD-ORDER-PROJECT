resource "aws_security_group" "production_alb" {
  name        = "production-alb-sg"
  description = "Security group for production ALB"
  vpc_id      = aws_vpc.production_vpc.id

  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "production-alb-sg"
  }
}

resource "aws_security_group" "production_app" {
  name        = "production-app-sg"
  description = "Security group for production application"
  vpc_id      = aws_vpc.production_vpc.id

  ingress {
    description     = "Allow application traffic from ALB"
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.production_alb.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "production-app-sg"
  }
}

resource "aws_security_group" "production_rds" {
  name        = "production-rds-sg"
  description = "Security group for production RDS"
  vpc_id      = aws_vpc.production_vpc.id

  ingress {
    description     = "Allow MySQL from application"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.production_app.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "production-rds-sg"
  }
}

resource "aws_security_group" "production_vpc_endpoints" {
  name        = "production-vpc-endpoints-sg"
  description = "Security group for production VPC interface endpoints"
  vpc_id      = aws_vpc.production_vpc.id

  ingress {
    description     = "Allow HTTPS from application"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.production_app.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "production-vpc-endpoints-sg"
  }
}
