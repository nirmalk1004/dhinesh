resource "aws_ecs_cluster" "rail_web_app_cluster" {
  name = "rail-web-app-cluster"
}

resource "aws_ecs_task_definition" "rail_web_app_task" {
  family                   = "rail-web-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([{
    name  = "rail-web-app-container"
    image = aws_ecr_repository.rail_web_app.repository_url

    environment = [
      { name = "DATABASE_HOST", value = aws_db_instance.rail_web_app_db.address },
      { name = "DATABASE_NAME", value = aws_db_instance.rail_web_app_db.name },
      { name = "DATABASE_USER", value = aws_db_instance.rail_web_app_db.username },
      { name = "DATABASE_PASSWORD", value = aws_db_instance.rail_web_app_db.password },
      { name = "S3_BUCKET", value = aws_s3_bucket.rail_web_app_bucket.id },
    ]
  }])
}
