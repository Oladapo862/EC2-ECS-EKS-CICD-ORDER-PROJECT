resource "aws_iam_policy" "production_ec2_cloudwatch" {
  name        = "production-ec2-cloudwatch-policy"
  description = "Allow production EC2 to publish metrics and logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "cloudwatch:PutMetricData",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "production-ec2-cloudwatch-policy"
  }
}

resource "aws_iam_role_policy_attachment" "production_ec2_cloudwatch" {
  role       = aws_iam_role.production_ec2.name
  policy_arn = aws_iam_policy.production_ec2_cloudwatch.arn
}
