resource "aws_ecs_service" "rail_web_app_service" {
  name            = "rail-web-app-service"
  cluster         = aws_ecs_cluster.rail_web_app_cluster.id
  task_definition = aws_ecs_task_definition.rail_web_app_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets = aws_subnet.public_subnets[*].id
    security_groups = [aws_security_group.rail_web_app_sg.id]
  }
}

resource "aws_lb" "rail_web_app_lb" {
  name               = "rail-web-app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public_subnets[*].id
}

resource "aws_lb_target_group" "rail_web_app_target_group" {
  name     = "rail-web-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "rail_web_app_listener" {
  load_balancer_arn = aws_lb.rail_web_app_lb.arn
  port              = 80
  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
    }
  }
}

output "application_url" {
  value = aws_lb.rail_web_app_lb.dns_name
}

output "lb_endpoint" {
  value = aws_lb.rail_web_app_lb.dns_name
}
