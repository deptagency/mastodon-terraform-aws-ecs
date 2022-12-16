
locals {
  db_security_groups = var.bastion_enabled ? [aws_security_group.mastodon_db.id, aws_security_group.mastodon_bastion_db_sg[0].id] : [ aws_security_group.mastodon_db.id ]
}
resource "aws_db_instance" "mastodon" {
  allocated_storage          = 20
  auto_minor_version_upgrade = true
  backup_retention_period    = 7
  backup_window              = "20:00-21:00"
  db_subnet_group_name       = "${aws_db_subnet_group.mastodon.name}"
  engine                     = "postgres"
  engine_version             = "13.7"
  identifier                 = "${var.aws_resource_base_name}"
  instance_class             = "${var.aws_db_instance_mastodon_instance_class}"
  multi_az                   = false
  db_name                    = "mastodon"
  parameter_group_name       = "${aws_db_parameter_group.mastodon.name}"
  password                   = "${var.mastodon_db_pass}"
  skip_final_snapshot        = true
  username                   = "${var.mastodon_db_user}"

  vpc_security_group_ids = local.db_security_groups
}
