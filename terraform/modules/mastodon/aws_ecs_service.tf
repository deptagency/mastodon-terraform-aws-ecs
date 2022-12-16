resource "aws_ecs_service" "mastodon_node_streaming" {
  cluster                            = "${aws_ecs_cluster.mastodon.id}"
  deployment_minimum_healthy_percent = 50
  desired_count                      = "${var.aws_ecs_service_desired_count_node_streaming}"
  #iam_role                           = "${aws_iam_role.mastodon_ecs.arn}"
  name                               = "${var.aws_resource_base_name}_node_streaming"

  launch_type                        = "FARGATE"

  network_configuration {
    # TODO change to private link to save money? 
    # https://www.easydeploy.io/blog/how-to-create-private-link-for-ecr-to-ecs-containers-to-save-nat-gatewayec2-other-charges/
    subnets = concat(aws_subnet.mastodon_private_a.*.id, aws_subnet.mastodon_private_c.*.id)
    # TODO narrow down security groups a bit more to provide least access?
    security_groups = [ aws_security_group.mastodon_alb.id, 
      aws_security_group.mastodon_web.id, 
      aws_security_group.mastodon_db.id, 
      aws_security_group.mastodon_elasticache.id ]
  }
  load_balancer {
    container_name   = "${var.aws_resource_base_name}_node_streaming"
    container_port   = "${var.mastodon_node_streaming_port}"
    target_group_arn = "${aws_alb_target_group.mastodon_node_streaming.arn}"
  }

  task_definition = "${aws_ecs_task_definition.mastodon_node_streaming.arn}"
}

resource "aws_ecs_service" "mastodon_rails_puma" {
  cluster                            = "${aws_ecs_cluster.mastodon.id}"
  deployment_minimum_healthy_percent = 50
  desired_count                      = "${var.aws_ecs_service_desired_count_rails_puma}"
  #iam_role                           = "${aws_iam_role.mastodon_ecs.arn}"
  name                               = "${var.aws_resource_base_name}_rails_puma"

  network_configuration {
    # TODO change to private link to save money? 
    # https://www.easydeploy.io/blog/how-to-create-private-link-for-ecr-to-ecs-containers-to-save-nat-gatewayec2-other-charges/
    subnets = concat(aws_subnet.mastodon_private_a.*.id, aws_subnet.mastodon_private_c.*.id)
    # TODO narrow down security groups a bit more to provide least access?
    security_groups = [ aws_security_group.mastodon_alb.id, 
      aws_security_group.mastodon_web.id, 
      aws_security_group.mastodon_db.id, 
      aws_security_group.mastodon_elasticache.id ]
  }

  launch_type                        = "FARGATE"
  load_balancer {
    container_name   = "${var.aws_resource_base_name}_rails_puma"
    container_port   = "3000"
    target_group_arn = "${aws_alb_target_group.mastodon_rails_puma.arn}"
  }

  task_definition = "${aws_ecs_task_definition.mastodon_rails_puma.arn}"
}

resource "aws_ecs_service" "mastodon_rails_sidekiq" {
  cluster                            = "${aws_ecs_cluster.mastodon.id}"
  deployment_minimum_healthy_percent = 50
  launch_type                        = "FARGATE"
  desired_count                      = "${var.aws_ecs_service_desired_count_rails_sidekiq}"
  name                               = "${var.aws_resource_base_name}_rails_sidekiq"
  task_definition                    = "${aws_ecs_task_definition.mastodon_rails_sidekiq.arn}"

  network_configuration {
    # TODO change to private link to save money? 
    # https://www.easydeploy.io/blog/how-to-create-private-link-for-ecr-to-ecs-containers-to-save-nat-gatewayec2-other-charges/
    subnets = concat(aws_subnet.mastodon_private_a.*.id, aws_subnet.mastodon_private_c.*.id)
    # TODO narrow down security groups a bit more to provide least access?
    security_groups = [ aws_security_group.mastodon_alb.id, 
      aws_security_group.mastodon_web.id, 
      aws_security_group.mastodon_db.id, 
      aws_security_group.mastodon_elasticache.id ]
  }
}
