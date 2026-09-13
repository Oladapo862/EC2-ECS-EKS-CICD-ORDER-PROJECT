resource "aws_route_table_association" "production_public_1" {
  subnet_id      = aws_subnet.production_public_1.id
  route_table_id = aws_route_table.production_public.id
}

resource "aws_route_table_association" "production_public_2" {
  subnet_id      = aws_subnet.production_public_2.id
  route_table_id = aws_route_table.production_public.id
}

resource "aws_route_table_association" "production_private_app_1" {
  subnet_id      = aws_subnet.production_private_app_1.id
  route_table_id = aws_route_table.production_private_app.id
}

resource "aws_route_table_association" "production_private_app_2" {
  subnet_id      = aws_subnet.production_private_app_2.id
  route_table_id = aws_route_table.production_private_app.id
}

resource "aws_route_table_association" "production_private_db_1" {
  subnet_id      = aws_subnet.production_private_db_1.id
  route_table_id = aws_route_table.production_private_db.id
}

resource "aws_route_table_association" "production_private_db_2" {
  subnet_id      = aws_subnet.production_private_db_2.id
  route_table_id = aws_route_table.production_private_db.id
}
