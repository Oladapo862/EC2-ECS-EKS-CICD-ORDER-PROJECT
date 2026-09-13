resource "aws_db_subnet_group" "production_rds" {
  name = "production-rds-subnet-group"

  subnet_ids = [
    aws_subnet.production_private_db_1.id,
    aws_subnet.production_private_db_2.id
  ]

  tags = {
    Name = "production-rds-subnet-group"
  }
}

resource "aws_db_instance" "production_rds" {
  identifier = "production-rds"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = "orders"
  username = "admin"
  password = var.rds_password

  db_subnet_group_name = aws_db_subnet_group.production_rds.name

  vpc_security_group_ids = [
    aws_security_group.production_rds.id
  ]

  publicly_accessible = false
  multi_az            = true

  backup_retention_period = 7
  deletion_protection     = true
  skip_final_snapshot     = false

  tags = {
    Name = "production-rds"
  }
}
