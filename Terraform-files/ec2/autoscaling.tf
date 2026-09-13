resource "aws_autoscaling_group" "production_app" {
  name = "production-app-asg"

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  vpc_zone_identifier = [
    aws_subnet.production_private_app_1.id,
    aws_subnet.production_private_app_2.id
  ]

  target_group_arns = [
    aws_lb_target_group.production_app.arn
  ]

  launch_template {
    id      = aws_launch_template.production_app.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "production-app"
    propagate_at_launch = true
  }
}
