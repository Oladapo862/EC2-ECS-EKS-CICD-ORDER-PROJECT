variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "eu-west-1"
}
variable "rds_password" {
  description = "Master password for the production RDS database"
  type        = string
  sensitive   = true
}
