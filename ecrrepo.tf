resource "aws_ecr_repository" "rail_web_app" {
  name = var.ecr_repo_name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.rail_web_app.repository_url
}