variable "aws_launch_configuration_ami_id" {}

variable "aws_region" {}

variable "mastodon_aws_access_key_id" {}

variable "mastodon_aws_secret_access_key" {}

variable "mastodon_cdn_host" {}

variable "mastodon_db_host" {}

variable "mastodon_db_name" {}

variable "mastodon_db_pass" {}

variable "mastodon_db_port" {}

variable "mastodon_db_user" {}

variable "mastodon_default_locale" {
  default = "en"
}

variable "mastodon_docker_image_tag" {}

variable "mastodon_email_domain_blacklist" {}

variable "mastodon_email_domain_whitelist" {}

variable "mastodon_local_domain" {
  default = "example.com"
}

variable "mastodon_local_https" {
  default = "false"
}

variable "mastodon_node_env" {
  default = "production"
}

variable "mastodon_otp_secret" {}

variable "mastodon_paperclip_root_path" {
  default = ":rails_root/public/system"
}

variable "mastodon_paperclip_root_url" {
  default = "/system"
}

variable "mastodon_paperclip_secret" {}

variable "mastodon_prepared_statements" {
  default = "true"
}

variable "mastodon_redis_host" {}

variable "mastodon_redis_password" {}

variable "mastodon_redis_port" {}

variable "mastodon_s3_bucket" {}

variable "mastodon_s3_cloudfront_host" {}

variable "mastodon_s3_enabled" {
  default = "true"
}

variable "mastodon_s3_endpoint" {}

variable "mastodon_s3_hostname" {}

variable "mastodon_s3_protocol" {}

variable "mastodon_s3_region" {}

variable "mastodon_secret_key_base" {}

variable "mastodon_single_user_mode" {
  default = "false"
}

variable "mastodon_smtp_auth_method" {}

variable "mastodon_smtp_delivery_method" {}

variable "mastodon_smtp_domain" {}

variable "mastodon_smtp_enable_starttls_auto" {}

variable "mastodon_smtp_from_address" {}

variable "mastodon_smtp_login" {}

variable "mastodon_smtp_openssl_verify_mode" {}

variable "mastodon_smtp_password" {}

variable "mastodon_smtp_port" {}

variable "mastodon_smtp_server" {}

variable "mastodon_streaming_api_base_url" {}

variable "mastodon_streaming_cluster_num" {
  default = "1"
}

variable "mastodon_streaming_log_level" {
  default = "verbose"
}

variable "mastodon_streaming_port" {
  default = "4000"
}