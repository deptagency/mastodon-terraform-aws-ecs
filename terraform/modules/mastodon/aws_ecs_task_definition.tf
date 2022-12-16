resource "aws_ecs_task_definition" "mastodon_node_streaming" {
  family = "${var.aws_resource_base_name}_node_streaming"
  requires_compatibilities = ["FARGATE"]
  memory = var.aws_ecs_task_definition_mastodon_node_streaming_memory
  cpu = var.aws_ecs_task_definition_mastodon_node_streaming_cpu
  task_role_arn = "${aws_iam_role.mastodon_rails.arn}"
  execution_role_arn       = aws_iam_role.mastodon_task_execution_role.arn
  network_mode = "awsvpc"

  container_definitions = jsonencode(
    [
      {
        "command": ["yarn", "run", "start"],
        "environment": "${local.mastodon_environment_variables_streaming}",
        "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
        "requires_compatibilities" : ["FARGATE"],
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.aws_resource_base_name}",
            "awslogs-region": "${data.aws_region.current.name}",
            "awslogs-stream-prefix": "streaming"
          }
        },
        "name": "${var.aws_resource_base_name}_node_streaming",
        "portMappings": [
          {
            "containerPort": "${var.mastodon_node_streaming_port}",
            "protocol": "tcp"
          }
        ]
      }
    ]
  )
}

resource "aws_ecs_task_definition" "mastodon_rails_db_migration" {
  family = "${var.aws_resource_base_name}_rails_db_migration"
  requires_compatibilities = ["FARGATE"]
  memory = var.aws_ecs_task_definition_mastodon_rails_db_migration_memory
  cpu = var.aws_ecs_task_definition_mastodon_rails_db_migration_cpu
  task_role_arn = "${aws_iam_role.mastodon_rails.arn}"
  execution_role_arn       = aws_iam_role.mastodon_task_execution_role.arn
  network_mode = "awsvpc"

  container_definitions = jsonencode(
    [
      {
        "command": ["bundle", "exec", "rake", "db:migrate"],
        "environment": "${local.mastodon_environment_variables_rails}",
        "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag_rails_db_migration}",
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.aws_resource_base_name}",
            "awslogs-region": "${data.aws_region.current.name}",
            "awslogs-stream-prefix": "rails_db_migration"
          }
        },
        "name": "${var.aws_resource_base_name}_rails_db_migration"
      }
    ]
  )

}

resource "aws_ecs_task_definition" "mastodon_rails_db_set_up" {
  family = "${var.aws_resource_base_name}_rails_db_set_up"
  requires_compatibilities = ["FARGATE"]
  memory = var.aws_ecs_task_definition_mastodon_rails_db_set_up_memory
  cpu = var.aws_ecs_task_definition_mastodon_rails_db_set_up_cpu
  task_role_arn = "${aws_iam_role.mastodon_rails.arn}"
  execution_role_arn       = aws_iam_role.mastodon_task_execution_role.arn
  network_mode = "awsvpc"
  container_definitions = jsonencode(
    [
      {
        "command": ["bundle", "exec", "rails", "db:setup"],
        "environment": "${local.mastodon_environment_variables_rails}",
        "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
        "requires_compatibilities" : ["FARGATE"],
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.aws_resource_base_name}",
            "awslogs-region": "${data.aws_region.current.name}",
            "awslogs-stream-prefix": "rails_db_set_up"
          }
        },
        "name": "${var.aws_resource_base_name}_rails_db_set_up"
      }
    ]
  )

}

resource "aws_ecs_task_definition" "mastodon_rails_mastodon_make_admin" {
  family = "${var.aws_resource_base_name}_rails_mastodon_make_admin"
  requires_compatibilities = ["FARGATE"]
  memory = var.aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_memory
  cpu = var.aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_cpu
  task_role_arn = "${aws_iam_role.mastodon_rails.arn}"
  execution_role_arn       = aws_iam_role.mastodon_task_execution_role.arn
  network_mode = "awsvpc"

  container_definitions = jsonencode(
    [
      {
        "command": ["bin/tootctl", "accounts", "modify", "${var.mastodon_administrator_name}", "--role", "Owner"]
        "environment": "${local.mastodon_environment_variables_rails}",
        "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
        "requires_compatibilities" : ["FARGATE"],
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.aws_resource_base_name}",
            "awslogs-region": "${data.aws_region.current.name}",
            "awslogs-stream-prefix": "rails_mastodon_make_admin"
          }
        },
        "name": "${var.aws_resource_base_name}_rails_mastodon_make_admin"
      }
    ]
  )
}

resource "aws_ecs_task_definition" "mastodon_rails_mastodon_add_user" {
  family = "${var.aws_resource_base_name}_rails_mastodon_add_user"
  requires_compatibilities = ["FARGATE"]
  memory = var.aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_memory
  cpu = var.aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_cpu
  task_role_arn = "${aws_iam_role.mastodon_rails.arn}"
  execution_role_arn       = aws_iam_role.mastodon_task_execution_role.arn
  network_mode = "awsvpc"

  container_definitions = jsonencode(
    [
      {
        "command": ["bin/tootctl", "accounts", "create", "placeholderusername", "--confirmed", "--email", "placeholder@placeholder.xxx"]
        "environment": "${local.mastodon_environment_variables_rails}",
        "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
        "requires_compatibilities" : ["FARGATE"],
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.aws_resource_base_name}",
            "awslogs-region": "${data.aws_region.current.name}",
            "awslogs-stream-prefix": "rails_mastodon_make_admin"
          }
        },
        "name": "${var.aws_resource_base_name}_rails_mastodon_make_admin"
      }
    ]
  )
}

resource "aws_ecs_task_definition" "mastodon_rails_puma" {
  family = "${var.aws_resource_base_name}_rails_puma"
  requires_compatibilities = ["FARGATE"]
  memory = var.aws_ecs_task_definition_mastodon_rails_puma_memory
  cpu = var.aws_ecs_task_definition_mastodon_rails_puma_cpu
  task_role_arn = "${aws_iam_role.mastodon_rails.arn}"
  execution_role_arn       = aws_iam_role.mastodon_task_execution_role.arn
  network_mode = "awsvpc"

  container_definitions = jsonencode(
    [
      {
        "command": ["bundle", "exec", "puma", "--config", "config/puma.rb", "--environment", "production"],
        "environment": "${local.mastodon_environment_variables_rails}",
        "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.aws_resource_base_name}",
            "awslogs-region": "${data.aws_region.current.name}",
            "awslogs-stream-prefix": "rails_puma"
          }
        },
        "name": "${var.aws_resource_base_name}_rails_puma",
        "portMappings": [
          {
            "containerPort": 3000,
            "protocol": "tcp"
          }
        ]
      }
    ]
  )

}

resource "aws_ecs_task_definition" "mastodon_rails_sidekiq" {
  family = "${var.aws_resource_base_name}_rails_sidekiq"
  requires_compatibilities = ["FARGATE"]
  memory = var.aws_ecs_task_definition_mastodon_rails_sidekiq_memory
  cpu = var.aws_ecs_task_definition_mastodon_rails_sidekiq_cpu
  task_role_arn = "${aws_iam_role.mastodon_rails.arn}"
  execution_role_arn       = aws_iam_role.mastodon_task_execution_role.arn
  network_mode = "awsvpc"

  container_definitions = jsonencode(
    [
      {
        "command": ["bundle", "exec", "sidekiq"],
        "environment": "${local.mastodon_environment_variables_rails}",
        "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.aws_resource_base_name}",
            "awslogs-region": "${data.aws_region.current.name}",
            "awslogs-stream-prefix": "rails_sidekiq"
          }
        },
        "name": "${var.aws_resource_base_name}_rails_sidekiq",
        "healthCheck" : {
            retries = 10
            command = [ "CMD-SHELL", "ps aux | grep '[s]idekiq\\ 6' || false"]
            timeout: 5
            interval: 60
            startPeriod: 100
        }

      },
    ]
  )

}
