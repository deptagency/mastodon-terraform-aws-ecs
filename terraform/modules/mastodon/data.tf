data "aws_region" "current" {
}

locals {
    mastodon_redis_host          = "${aws_elasticache_cluster.mastodon.cache_nodes.0.address}"
    mastodon_redis_port          = "${aws_elasticache_cluster.mastodon.cache_nodes.0.port}"
    mastodon_local_https         = "${var.aws_acm_certificate_arn == "" ? "false" : "true"}"
    # TODO better way to do this?
    # mastodon_alb_public_ips      = join(",", formatlist("%s", [for eni in data.aws_network_interface.alb_enis : eni.public_ip]))
  }

#data "aws_network_interface" "alb_enis" {
#  for_each = toset([aws_subnet.mastodon_public_a.id, aws_subnet.mastodon_public_c.id])
#
#  filter {
#    name   = "description"
#    values = ["ELB ${aws_alb.mastodon.arn_suffix}"]
#  }
#
#  filter {
#    name   = "subnet-id"
#    values = [each.value]
#  }
#}
locals {
    mastodon_environment_variables_rails = [
      {
        name : "AWS_ACCESS_KEY_ID",
        value : var.mastodon_aws_access_key_id
      },
      {
        name : "AWS_SECRET_ACCESS_KEY",
        value : var.mastodon_aws_secret_access_key
      },
      {
        name : "DB_HOST",
        value : aws_db_instance.mastodon.address
      },
      {
        name : "DB_NAME",
        value : aws_db_instance.mastodon.db_name
      },
      {
        name : "DB_PASS",
        value : var.mastodon_db_pass
      },
      {
        name : "DB_PORT",
        value : tostring(aws_db_instance.mastodon.port)
      },
      {
        name : "DB_USER",
        value : var.mastodon_db_user
      },
      {
        name : "DEFAULT_LOCALE",
        value : var.mastodon_default_locale
      },
      {
        name : "EMAIL_DOMAIN_BLACKLIST",
        value : var.mastodon_email_domain_blacklist
      },
      {
        name : "EMAIL_DOMAIN_WHITELIST",
        value : var.mastodon_email_domain_whitelist
      },
      {
        name : "LOCAL_DOMAIN",
        value : var.mastodon_local_domain
      },
      {
        name : "ALTERNATE_DOMAINS",
        value : format("%s,%s", "${var.mastodon_alternate_domains}",aws_alb.mastodon.dns_name)
      },
      {
        name : "LOCAL_HTTPS",
        value : local.mastodon_local_https
      },
      {
        name : "OTP_SECRET",
        value : var.mastodon_otp_secret
      },
      {
        name : "PAPERCLIP_ROOT_PATH",
        value : var.mastodon_paperclip_root_path
      },
      {
        name : "PAPERCLIP_ROOT_URL",
        value : var.mastodon_paperclip_root_url
      },
      {
        name : "PAPERCLIP_SECRET",
        value : var.mastodon_paperclip_secret
      },
      {
        name : "PREPARED_STATEMENTS",
        value : var.mastodon_prepared_statements
      },
      {
        name: "RAILS_LOG_LEVEL",
        value: var.mastodon_rails_log_level
      },
      {
        name : "REDIS_HOST",
        value : local.mastodon_redis_host
      },
      {
        name : "REDIS_PORT",
        value : tostring(local.mastodon_redis_port)
      },
      {
        name : "S3_BUCKET",
        value : var.aws_s3_bucket_name
      },
      {
        name : "S3_CLOUDFRONT_HOST",
        value : var.mastodon_s3_cloudfront_host
      },
      {
        name : "S3_ENABLED",
        value : "true"
      },
      {
        name : "S3_REGION",
        value : data.aws_region.current.name
      },
      {
        name : "SECRET_KEY_BASE",
        value : var.mastodon_secret_key_base
      },
      {
        name : "SINGLE_USER_MODE",
        value : var.mastodon_single_user_mode
      },
      {
        name : "SMTP_AUTH_METHOD",
        value : var.mastodon_smtp_auth_method
      },
      {
        name : "SMTP_DELIVERY_METHOD",
        value : var.mastodon_smtp_delivery_method
      },
      {
        name : "SMTP_DOMAIN",
        value : var.mastodon_smtp_domain
      },
      {
        name : "SMTP_ENABLE_STARTTLS_AUTO",
        value : var.mastodon_smtp_enable_starttls_auto
      },
      {
        name : "SMTP_FROM_ADDRESS",
        value : var.mastodon_smtp_from_address
      },
      {
        name : "SMTP_LOGIN",
        value : var.mastodon_smtp_login
      },
      {
        name : "SMTP_OPENSSL_VERIFY_MODE",
        value : var.mastodon_smtp_openssl_verify_mode
      },
      {
        name : "SMTP_PASSWORD",
        value : var.mastodon_smtp_password
      },
      {
        name : "SMTP_PORT",
        value : var.mastodon_smtp_port
      },
      {
        name : "SMTP_SERVER",
        value : var.mastodon_smtp_server
      },
      {
        name : "SMTP_SSL",
        value : var.mastodon_smtp_ssl
      },
      {
        name : "STREAMING_API_BASE_URL",
        value : var.mastodon_node_streaming_api_base_url
      },
      {
        name : "STREAMING_CLUSTER_NUM",
        value : var.mastodon_node_streaming_cluster_num
      }
    ]
}
locals {
  mastodon_environment_variables_streaming = [
      {
        name : "DB_HOST",
        value : aws_db_instance.mastodon.address
      },
      {
        name : "DB_NAME",
        value : aws_db_instance.mastodon.db_name
      },
      {
        name : "DB_PASS",
        value : var.mastodon_db_pass
      },
      {
        name : "DB_PORT",
        # TODO why tostring?
        value : tostring(aws_db_instance.mastodon.port)
      },
      {
        name : "DB_USER",
        value : var.mastodon_db_user
      },
      {
        name : "NODE_ENV",
        value : "production"
      },
      {
        name : "REDIS_HOST",
        value : local.mastodon_redis_host
      },
      {
        name : "REDIS_PORT",
        # TODO why tostring?
        value : tostring(local.mastodon_redis_port)
      }
    ]
} 
