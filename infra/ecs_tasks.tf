resource "aws_ecs_task_definition" "api_task_definition" {
  family       = "api-task"
  network_mode = "awsvpc"
  cpu          = "256"
  memory       = "512"
  container_definitions = jsonencode([
    {
      "name" : "hello",
      "image" : "${aws_ecr_repository.hometask.repository_url}:${app_version}}",
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort" : 0,
          "protocol" : "tcp"
        }
      ],
      "healthCheck" : {
        "command" : ["CMD-SHELL", "curl -f http://localhost:80/health || exit 1"],
        "interval" : 30,
        "timeout" : 5,
        "retries" : 3,
        "startPeriod" : 60
      },
      "environment" : [
        {
          "name" : "DB_HOST",
          "value" : aws_db_instance.users.address
        },
        {
          "name" : "DB_PORT",
          "value" : aws_db_instance.users.port
        },
        {
          "name" : "DB_USER",
          "value" : aws_db_instance.users.username
        },
        {
          "name" : "DB_PASSWORD",
          "value" : aws_db_instance.users.password
        },
        {
          "name" : "DB_NAME",
          "value" : aws_db_instance.users.name
        }
      ]
    }
  ])
}


resource "aws_ecs_service" "service" {
  name            = "api-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.api_task_definition.arn
  desired_count   = 3
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = [aws_subnet.subnets[*].id]
    security_groups = [aws_security_group.api_sg.id]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = "hello"
    container_port   = 80
  }
}
