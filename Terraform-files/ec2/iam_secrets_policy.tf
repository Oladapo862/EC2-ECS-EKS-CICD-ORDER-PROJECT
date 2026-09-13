resource "aws_iam_policy" "production_ec2_secrets" {
  name        = "production-ec2-secrets-policy"
  description = "Allow production EC2 to read RDS credentials from Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = "arn:aws:secretsmanager:eu-west-1:*:secret:production/rds/credentials-*"
      }
    ]
  })

  tags = {
    Name = "production-ec2-secrets-policy"
  }
}

resource "aws_iam_role_policy_attachment" "production_ec2_secrets" {
  role       = aws_iam_role.production_ec2.name
  policy_arn = aws_iam_policy.production_ec2_secrets.arn
}
