module "mastodon" {
  aws_acm_certificate_arn                                           = "${var.aws_acm_certificate_arn}"
  aws_acm_certificate_arn_for_alb                                   = "${var.aws_acm_certificate_arn_for_alb}"
  aws_db_instance_mastodon_instance_class                           = "${var.aws_db_instance_mastodon_instance_class}"
  aws_ecs_service_desired_count_node_streaming                      = "${var.aws_ecs_service_desired_count_node_streaming}"
  aws_ecs_service_desired_count_rails_puma                          = "${var.aws_ecs_service_desired_count_rails_puma}"
  aws_ecs_service_desired_count_rails_sidekiq                       = "${var.aws_ecs_service_desired_count_rails_sidekiq}"
  aws_ecs_task_definition_mastodon_node_streaming_memory            = "${var.aws_ecs_task_definition_mastodon_node_streaming_memory}"
  aws_ecs_task_definition_mastodon_rails_db_migration_memory        = "${var.aws_ecs_task_definition_mastodon_rails_db_migration_memory}"
  aws_ecs_task_definition_mastodon_rails_db_set_up_memory           = "${var.aws_ecs_task_definition_mastodon_rails_db_set_up_memory}"
  aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_memory = "${var.aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_memory}"
  aws_ecs_task_definition_mastodon_rails_puma_memory                = "${var.aws_ecs_task_definition_mastodon_rails_puma_memory}"
  aws_ecs_task_definition_mastodon_rails_sidekiq_memory             = "${var.aws_ecs_task_definition_mastodon_rails_sidekiq_memory}"
  aws_ecs_task_definition_mastodon_node_streaming_cpu               = "${var.aws_ecs_task_definition_mastodon_node_streaming_cpu}"
  aws_ecs_task_definition_mastodon_rails_db_migration_cpu           = "${var.aws_ecs_task_definition_mastodon_rails_db_migration_cpu}"
  aws_ecs_task_definition_mastodon_rails_db_set_up_cpu              = "${var.aws_ecs_task_definition_mastodon_rails_db_set_up_cpu}"
  aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_cpu    = "${var.aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_cpu}"
  aws_ecs_task_definition_mastodon_rails_puma_cpu                   = "${var.aws_ecs_task_definition_mastodon_rails_puma_cpu}"
  aws_ecs_task_definition_mastodon_rails_sidekiq_cpu                = "${var.aws_ecs_task_definition_mastodon_rails_sidekiq_cpu}"
  aws_elasticache_cluster_node_type                                 = "${var.aws_elasticache_cluster_node_type}"
  aws_resource_base_name                                            = "${var.aws_resource_base_name}"
  aws_s3_bucket_name                                                = "${var.aws_s3_bucket_name}"
  bastion_enabled                                                   = "${var.bastion_enabled}"
  bastion_cidrs                                                     = "${var.bastion_cidrs}"
  bastion_ssh_key_name                                              = "${var.bastion_ssh_key_name}"
  mastodon_alternate_domains                                        = "${var.mastodon_alternate_domains}"
  mastodon_aws_access_key_id                                        = "${var.mastodon_aws_access_key_id}"
  mastodon_aws_secret_access_key                                    = "${var.mastodon_aws_secret_access_key}"
  mastodon_administrator_name                                       = "${var.mastodon_administrator_name}"
  mastodon_db_name                                                  = "${var.mastodon_db_name}"
  mastodon_db_pass                                                  = "${var.mastodon_db_pass}"
  mastodon_db_user                                                  = "${var.mastodon_db_user}"
  mastodon_default_locale                                           = "${var.mastodon_default_locale}"
  mastodon_docker_image_tag                                         = "${var.mastodon_docker_image_tag}"
  mastodon_docker_image_tag_rails_db_migration                      = "${var.mastodon_docker_image_tag_rails_db_migration}"
  mastodon_email_domain_blacklist                                   = "${var.mastodon_email_domain_blacklist}"
  mastodon_email_domain_whitelist                                   = "${var.mastodon_email_domain_whitelist}"
  mastodon_local_domain                                             = "${var.mastodon_local_domain}"
  mastodon_otp_secret                                               = "${var.mastodon_otp_secret}"
  mastodon_paperclip_root_path                                      = "${var.mastodon_paperclip_root_path}"
  mastodon_paperclip_root_url                                       = "${var.mastodon_paperclip_root_url}"
  mastodon_paperclip_secret                                         = "${var.mastodon_paperclip_secret}"
  mastodon_prepared_statements                                      = "${var.mastodon_prepared_statements}"
  mastodon_rails_log_level                                          = "${var.mastodon_rails_log_level}"
  mastodon_s3_cloudfront_host                                       = "${var.mastodon_s3_cloudfront_host}"
  mastodon_secret_key_base                                          = "${var.mastodon_secret_key_base}"
  mastodon_single_user_mode                                         = "${var.mastodon_single_user_mode}"
  mastodon_smtp_auth_method                                         = "${var.mastodon_smtp_auth_method}"
  mastodon_smtp_delivery_method                                     = "${var.mastodon_smtp_delivery_method}"
  mastodon_smtp_domain                                              = "${var.mastodon_smtp_domain}"
  mastodon_smtp_enable_starttls_auto                                = "${var.mastodon_smtp_enable_starttls_auto}"
  mastodon_smtp_from_address                                        = "${var.mastodon_smtp_from_address}"
  mastodon_smtp_login                                               = "${var.mastodon_smtp_login}"
  mastodon_smtp_openssl_verify_mode                                 = "${var.mastodon_smtp_openssl_verify_mode}"
  mastodon_smtp_password                                            = "${var.mastodon_smtp_password}"
  mastodon_smtp_port                                                = "${var.mastodon_smtp_port}"
  mastodon_smtp_server                                              = "${var.mastodon_smtp_server}"
  mastodon_smtp_ssl                                                 = "${var.mastodon_smtp_ssl}"
  mastodon_node_streaming_api_base_url                              = "${var.mastodon_node_streaming_api_base_url}"
  mastodon_node_streaming_cluster_num                               = "${var.mastodon_node_streaming_cluster_num}"
  source                                                            = "./modules/mastodon"
}
