resource "aws_ecr_repository" "production_app" {
  name                 = "production-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "production-app"
  }
}
