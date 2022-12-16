variable "aws_s3_bucket_terraform_state-name" {
}

variable "aws_acm_certificate_arn" {
}

variable "aws_acm_certificate_arn_for_alb" {
}

variable "bastion_enabled" {
  default = false
}
variable "bastion_cidrs" {
  description = "Comma separated list of CIDR blocks to whitelist for bastion host.  Run export TF_VAR_bastion_cidrs=$(curl -sq icanhazip.com)/32 to get your IP. "
  default = ""
}

variable "bastion_ssh_key_name" {
  default = ""
}

variable "aws_db_instance_mastodon_instance_class" {
  default = "db.t3.medium"
}

variable "aws_ecs_service_desired_count_node_streaming" {
  default = 1
}

variable "aws_ecs_service_desired_count_rails_puma" {
  default = 1
}

variable "aws_ecs_service_desired_count_rails_sidekiq" {
  default = 1
}

variable "aws_ecs_task_definition_mastodon_node_streaming_memory" {
  default = 512
}

variable "aws_ecs_task_definition_mastodon_node_streaming_cpu" {
  default = 256
}

variable "aws_ecs_task_definition_mastodon_rails_db_migration_memory" {
  default = 512
}

variable "aws_ecs_task_definition_mastodon_rails_db_migration_cpu" {
  default = 256
}

variable "aws_ecs_task_definition_mastodon_rails_db_set_up_memory" {
  default = 512
}

variable "aws_ecs_task_definition_mastodon_rails_db_set_up_cpu" {
  default = 256
}

variable "aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_memory" {
  default = 512
}
variable "aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_cpu" {
  default = 256
}

variable "aws_ecs_task_definition_mastodon_rails_puma_memory" {
  default = 512
}

variable "aws_ecs_task_definition_mastodon_rails_puma_cpu" {
  default = 256
}

variable "aws_ecs_task_definition_mastodon_rails_sidekiq_memory" {
  default = 512
}

variable "aws_ecs_task_definition_mastodon_rails_sidekiq_cpu" {
  default = 256
}

variable "aws_elasticache_cluster_node_type" {
  default = "cache.t2.micro"
}

variable "aws_resource_base_name" {
  default = "mastodon"
}

variable "aws_s3_bucket_name" {
}

variable "mastodon_administrator_name" {
  default = "mastodonadmin"
}

variable "mastodon_aws_access_key_id" {
  default = ""
}

variable "mastodon_aws_secret_access_key" {
  default = ""
}

variable "mastodon_db_name" {
  default = "mastodon"
}

variable "mastodon_db_pass" {}

variable "mastodon_db_user" {
  default = "root"
}

variable "mastodon_default_locale" {
  default = "en"
}

variable "mastodon_docker_image_tag" {
  default = "v4.0.2"
}

variable "mastodon_docker_image_tag_rails_db_migration" {
  default = "v4.0.2"
}

variable "mastodon_email_domain_blacklist" {
  default = ""
}

variable "mastodon_email_domain_whitelist" {
}

variable "mastodon_local_domain" {
}

variable "mastodon_alternate_domains" {
}

variable "mastodon_otp_secret" {}

variable "mastodon_paperclip_root_path" {
  default = ":rails_root/public/system"
}

variable "mastodon_rails_log_level" {
  default = "info"
}

variable "mastodon_paperclip_root_url" {
  default = "/system"
}

variable "mastodon_paperclip_secret" {
  default = ""
}

variable "mastodon_prepared_statements" {
  default = "true"
}

variable "mastodon_s3_cloudfront_host" {
}

variable "mastodon_secret_key_base" {}

variable "mastodon_single_user_mode" {
  default = "false"
}

variable "mastodon_smtp_auth_method" {
  default = "plain"
}

variable "mastodon_smtp_delivery_method" {
  default = "smtp"
}

variable "mastodon_smtp_domain" {
  default = "example.com"
}

variable "mastodon_smtp_enable_starttls_auto" {
  default = "true"
}

variable "mastodon_smtp_from_address" {
  default = ""
}

variable "mastodon_smtp_login" {
  default = ""
}

variable "mastodon_smtp_openssl_verify_mode" {
  default = "none"
}

variable "mastodon_smtp_password" {
  default = ""
}

variable "mastodon_smtp_port" {
  default = ""
}

variable "mastodon_smtp_server" {
  default = ""
}

variable "mastodon_smtp_ssl" {
  default = "true"
}

variable "mastodon_node_streaming_api_base_url" {
  default = ""
}

variable "mastodon_node_streaming_cluster_num" {
  default = "1"
}
