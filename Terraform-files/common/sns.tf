resource "aws_sns_topic" "production_alerts" {
  name = "production-alerts"

  tags = {
    Name = "production-alerts"
  }
}
