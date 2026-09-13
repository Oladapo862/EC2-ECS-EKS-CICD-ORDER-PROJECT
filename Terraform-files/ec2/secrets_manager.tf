resource "aws_secretsmanager_secret" "production_rds_credentials" {
  name = "production/rds/credentials"

  tags = {
    Name = "production-rds-credentials"
  }
}

resource "aws_secretsmanager_secret_version" "production_rds_credentials" {
  secret_id = aws_secretsmanager_secret.production_rds_credentials.id

  secret_string = jsonencode({
    username = "admin"
    password = var.rds_password
    engine   = "mysql"
    host     = aws_db_instance.production_rds.address
    port     = 3306
    database = "orders"
  })
}

