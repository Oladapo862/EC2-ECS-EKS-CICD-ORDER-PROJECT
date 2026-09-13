resource "aws_lb_listener" "production_http" {
  load_balancer_arn = aws_lb.production_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.production_app.arn
  }
}
