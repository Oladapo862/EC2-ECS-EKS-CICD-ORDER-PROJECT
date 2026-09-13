resource "aws_lb_target_group" "production_app" {
  name     = "production-app-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = aws_vpc.production_vpc.id

  health_check {
    enabled             = true
    path                = "/health"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "production-app-tg"
  }
}
