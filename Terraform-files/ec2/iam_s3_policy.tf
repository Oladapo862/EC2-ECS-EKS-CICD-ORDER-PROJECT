resource "aws_iam_policy" "production_ec2_s3" {
  name        = "production-ec2-s3-policy"
  description = "Allow production EC2 to access the production S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]

        Resource = [
          aws_s3_bucket.production.arn,
          "${aws_s3_bucket.production.arn}/*"
        ]
      }
    ]
  })

  tags = {
    Name = "production-ec2-s3-policy"
  }
}

resource "aws_iam_role_policy_attachment" "production_ec2_s3" {
  role       = aws_iam_role.production_ec2.name
  policy_arn = aws_iam_policy.production_ec2_s3.arn
}
