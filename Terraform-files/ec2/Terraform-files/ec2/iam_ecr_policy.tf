resource "aws_iam_policy" "production_ec2_ecr" {
  name        = "production-ec2-ecr-policy"
  description = "Allow EC2 to pull Docker images from Amazon ECR"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken"
        ]

        Resource = "*"
      },
      {
        Effect = "Allow"

        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]

        Resource = aws_ecr_repository.production_app.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "production_ec2_ecr" {
  role       = aws_iam_role.production_ec2.name
  policy_arn = aws_iam_policy.production_ec2_ecr.arn
}
