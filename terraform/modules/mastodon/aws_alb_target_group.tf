# wtf https://github.com/hashicorp/terraform-provider-aws/issues/1315
resource "random_string" "alb_prefix" {
  length  = 4
  upper   = false
  special = false
}
resource "aws_alb_target_group" "mastodon_node_streaming" {
  deregistration_delay = 10

  health_check {
    healthy_threshold   = 2
    interval            = 60
    matcher             = "401"
    path                = "/"
    timeout             = 10
    unhealthy_threshold = 5
  }

  name     = "${var.aws_resource_base_name}-node-streaming-${random_string.alb_prefix.result}"
  port     = "${var.mastodon_node_streaming_port}"
  protocol = "HTTP"
  target_type = "ip"

  stickiness {
    type = "lb_cookie"
  }

  vpc_id = "${aws_vpc.mastodon.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_target_group" "mastodon_rails_puma" {
  deregistration_delay = 10

  health_check {
    healthy_threshold   = 2
    interval            = 60
    matcher             = "200,301"
    path                = "/health"
    timeout             = 10
    unhealthy_threshold = 5
  }

  target_type = "ip"

  name     = "${var.aws_resource_base_name}-rails-puma-${random_string.alb_prefix.result}"
  port     = 80
  protocol = "HTTP"

  stickiness {
    type = "lb_cookie"
  }

  vpc_id = "${aws_vpc.mastodon.id}"

  lifecycle {
    create_before_destroy = true
  }
}
