resource "aws_ecs_task_definition" "api_task_definition" {
  family                   = "dev-backend-task"
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      "name": "hello",
      "image": "${aws_ecr_repository.repository.repository_url}:latest",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 0,
          "protocol": "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "service" {
  name                = "dev-backend-service"
  cluster             = aws_ecs_cluster.cluster.id
  task_definition     = aws_ecs_task_definition.api_task_definition.arn
  desired_count       = 3
  launch_type         = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.subnets[*].id]
    security_groups  = [aws_security_group.sg.id]
  }
}
