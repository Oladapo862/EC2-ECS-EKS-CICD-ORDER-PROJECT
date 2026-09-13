resource "aws_iam_role_policy_attachment" "production_ec2_ssm" {
  role       = aws_iam_role.production_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
