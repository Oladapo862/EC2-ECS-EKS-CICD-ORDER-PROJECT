resource "aws_lb" "production_alb" {
  name               = "production-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.production_alb.id
  ]

  subnets = [
    aws_subnet.production_public_1.id,
    aws_subnet.production_public_2.id
  ]

  tags = {
    Name = "production-alb"
  }
}
