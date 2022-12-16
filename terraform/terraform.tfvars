aws_acm_certificate_arn = "arn:aws:acm:us-east-1:786164873757:certificate/b389ae2d-df69-4b6a-acec-cc20a69b61fb"
aws_acm_certificate_arn_for_alb = "arn:aws:acm:us-east-2:786164873757:certificate/02055ecf-da1e-4e31-80d0-4cfa9204537f"

aws_s3_bucket = "terraform-mastodon-bucket-2"
aws_s3_bucket_name = "matt-test-mastodon"
aws_s3_bucket_terraform_state-name="terraform.tfstate"
bastion_enabled = "true"
mastodon_docker_image_tag = "v4.0.2"

bastion_ssh_key_name = "dummy"

# note this one is comma separated
mastodon_alternate_domains = "https://domain1.com,https://domain2.com"

# note this one is pipe separated
mastodon_email_domain_whitelist ="domain1.com|domain2.com"
mastodon_local_domain = "domain1.com"
mastodon_s3_cloudfront_host = "yourcloudfronturl.cloudfront.net"

mastodon_smtp_auth_method = "plain"
mastodon_smtp_delivery_method = "smtp"
mastodon_smtp_domain = "domain1.com"
mastodon_smtp_enable_starttls_auto = "false"
mastodon_smtp_from_address = "help@domain1.com"
mastodon_smtp_port = "465"
mastodon_smtp_server = "your.mail.provider.com"
mastodon_smtp_ssl = "true"
mastodon_smtp_login = "mysmtplogin"
mastodon_smtp_openssl_verify_mode = "none"