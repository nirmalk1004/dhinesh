resource "aws_db_parameter_group" "custom_pg" {
  name        = "postres-rail"
  family      = "postgres13"  # Use the appropriate family
  description = "Custom parameter group for PostgreSQL"
}

resource "aws_db_instance" "rail_web_app_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "13.7"
  instance_class       = "db.t3.micro"
  db_name              = "rails"
  username             = "postgres"
  password             = "postgres"
  parameter_group_name = aws_db_parameter_group.custom_pg.name
  skip_final_snapshot  = true
}


output "database_url" {
  value = aws_db_instance.rail_web_app_db.endpoint  # Assuming 'rail_web_app_db' is the name of your RDS instance resource
}

output "rds_hostname" {
  value = aws_db_instance.rail_web_app_db.endpoint
}
