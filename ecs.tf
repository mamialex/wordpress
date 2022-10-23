resource "aws_ecs_cluster" "ecs" {
  name = "myecs"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecr_repository" "ecr-repo" {
  name                 = "ecr-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecs_task_definition" "wp" {
  family = "service"
  network_mode  = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn = aws_iam_role.wp-service-role.arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  cpu       = 256
  memory    = 512
  execution_role_arn = aws_iam_role.wp-service-role.arn
  container_definitions = jsonencode([
    {
      name      = "wp"
      image     = "${aws_ecr_repository.ecr-repo.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      environment = [
        {
          name = "WORDPRESS_DB_HOST"
          value = aws_db_instance.default.address
        },
        {
          name = "WORDPRESS_DB_USER"
          value = "wp"
        },
        {
          name = "WORDPRESS_DB_PASSWORD"
          value = local.db_pass
        },
        {
          name = "WORDPRESS_DB_NAME"
          value = "wordpress"
        }
      ]
    },
   ])
}

resource "aws_ecs_service" "wp" {
  name            = "wp-service"
  cluster         = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.wp.arn
  desired_count   = 1
  depends_on      = [aws_iam_role_policy.wp-service-role_policy]
  launch_type = "FARGATE"

  network_configuration {
    subnets = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
    security_groups = [aws_security_group.vp_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb.arn
    container_name   = "wp"
    container_port   = 80
  }
}