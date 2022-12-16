
Terraform scripts to create a Mastodon server in AWS Elastic Container Service (ECS).

Last tested with Mastodon version 4.0.2.

 Based upon original code from [mastodon-terraform](https://github.com/r7kamura/mastodon-terraform) by r7kamura as a basis.  From your friends at [DEPT® Agency](https://deptagency.com/service/engineering).

# Prereqs:

* [Terraform](https://www.terraform.io/)
* The [AWS CLI](https://aws.amazon.com/cli/) installed and configured
* An mail provider configured with smtp login, such as Simple Email Service from AWS.  (This setup isn't terraformed)
* An AWS ACM Certificate setup in the us-east-1 region to use HTTPS.

# Running from scratch

1. Create a certificate in ACM in the us-east-1 region, set the ARN to the `aws_acm_certificate_arn` variable in `terraform.tfvars`.
1. Setup the values needed for the `TF_VAR_mastodon_otp_secret` and `TF_VAR_mastodon_secret_key` described in the environment variables section.
1. Get the following secrets and run these commands to give Terraform the right secret and variable information, `.env.dummy` has them as well:
```sh
export AWS_DEFAULT_REGION=
export AWS_ACCESS_KEY_ID=
export TF_VAR_mastodon_otp_secret=
export TF_VAR_mastodon_db_pass=
export TF_VAR_mastodon_secret_key_base=
export TF_VAR_mastodon_smtp_login=
export TF_VAR_mastodon_smtp_password=
```
1. If you want a bastion host to access the database, set `bastion_enabled=true` in `terraform.tfvars`
1. Set any IP's in a comma separated list of CIDR addresses for access through the bastion host to this env var:  `TF_VAR_bastion_cidrs`
   a. Alternatively, you can run this command to find your IP and set it: `export TF_VAR_bastion_cidrs=$(curl -sq icanhazip.com)/32`
1. Set any other information required in `terraform.tfvars` (see sections below for required values)
1. Run `terraform plan` then `terraform apply`
1. Then `docker pull tootsuite/mastodon`
1. Go to the ECR Repo created and get the login commands, for instace `aws ecr get-login-password ... | docker login ...`
1. Then push and tag the image: `docker tag tootsuite/mastodon:{{mastodon version}} {{your ecr repo endpoint}}:{{mastodon version}}`
1. Set the `mastodon_docker_image_tag` in `terraform.tfvars` to your version of Mastodon you just tagged.
1. You may need to reset the `mastodon_s3_cloudfront_host` after running the `terraform plan` command the first time.
1. Run the `mastodon-rails-db-setup` task in the ECS console.  Make sure you choose the mastodon VPC, a public subnet and the DB security group.
1. Run the `mastodon-rails-db-migration` task in the ECS console with the same settings as above
1. Create an admin account: https://docs.joinmastodon.org/admin/setup/#admin
1. Run the `mastodon_rails_mastodon_make_admin` task in the ECS console for the username.

# Required environment variables

### AWS_DEFAULT_REGION

AWS region that the resources will be located in.

e.g. `us-east-1`
### AWS_ACCESS_KEY_ID

AWS IAM User access key ID for Terraform.

e.g. `ABCDEFGHIJKLMNOPQRST`

### AWS_SECRET_ACCESS_KEY

AWS IAM User secret access key for Terraform.
### AWS_S3_BUCKET_TERRAFORM_STATE_NAME

The domain that your terraform state file will be stored.
To run Terraform from CircleCI, you need to prepare a private AWS S3 bucket to store your terraform state file.

e.g. `your-s3-bucket-name`

### AWS_S3_BUCKET_TERRAFORM_STATE_KEY

Where to locate the terraform state file on the specified AWS S3 bucket.

e.g. `terraform.tfstate` (recommended)

### TF_VAR_mastodon_otp_secret

One-time password secret. Keep this safe.

e.g. Generate a long random value like this:

```bash
ruby -r securerandom -e "puts SecureRandom.hex(64)"
```

### TF_VAR_mastodon_secret_key_base

The secret key base. Keep this safe.

e.g. Generate a long random value like this:

```bash
ruby -r securerandom -e "puts SecureRandom.hex(64)"
```

### TF_VAR_mastodon_db_pass

Database password.

e.g. Generate a long random value like this:

```bash
ruby -r securerandom -e "puts SecureRandom.hex(64)"
```

### TF_VAR_mastodon_smtp_password

The password for your SMTP service.

## Required values in `terraform.tfvars`

In many instances, you'll want to see the [Mastodon Configuring Your Environment](https://docs.joinmastodon.org/admin/config/)
page for a better description of these variables.  They are largely one for one.
### aws_s3_bucket_name

A valid S3 bucket name for uploading files (e.g. user profile images).

e.g. `my-mastodon`

### bastion_enabled

Setup an EC2 Bastion server for accessing the database remotely.

### bastion_ssh_key_name

An SSH keypair name from the Ec2 Console for being able to access the baston host if `bastion_enabled` is true. 

### mastodon_s3_cloudfront_host

The domain for the CloudFront distribution where uploaded files will be provided from.

e.g. `cdn.example.com`


### mastodon_docker_image_tag

Mastodon Docker image tag to detect which image to be deployed on ECS.  See instructions above on how to push. 
The public docker repo will not work.

Defaults to "v4.0.2"

e.g. `123`

Note: this variable is not required at the 1st time because we need to create ECR repository before building Mastodon Docker image.

### mastodon_docker_image_tag_rails_db_migration

Mastodon Docker image tag to detect which image to be deployed on ECS for `db:migrate` task.
Why this value exists is because sometimes you may want to apply database migration before deploying new revision of application.

e.g. `124`

Note: this variable is not required at the 1st time because we need to create ECR repository before building Mastodon Docker image.

### mastodon_local_domain

The domain that your Mastodon instance will run on.

e.g. `mastodon.example.com`


## Optional environment variables

### aws_acm_certificate_arn

If you want to use HTTPS,
create free SSL certificate for your domain on Amazon Certificate Manager on us-east-1 region,
then set its ARN to this environment variable.

e.g. `arn:aws:acm:us-east-1:123456789012:certificate/12345678-90ab-cdef-1234-567890abcdef`

### aws_acm_certificate_arn_for_alb

For using secure WebSocket connection,
create free SSL certificate for your domain on Amazon Certificate Manager on your region,
then set its ARN to this environment variable too.

e.g. `arn:aws:acm:ap-northeast-1:123456789012:certificate/12345678-90ab-cdef-1234-567890abcdef`

### aws_db_instance_mastodon_instance_class

AWS RDS DB instance class.

default: `db.t2.micro`

FYI: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html.

### aws_ecs_task_definition_mastodon_node_streaming_memory

Memory size for node_streaming ECS task.

default: `300`

### aws_ecs_task_definition_mastodon_rails_db_migration_memory

Memory size for rails_db_migration ECS task.

default: `300`

### aws_ecs_task_definition_mastodon_rails_db_set_up_memory

Memory size for rails_db_set_up ECS task.

default: `300`

### aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_memory

Memory size for rails_mastodon_make_admin_memory ECS task.

default: `300`

### aws_ecs_task_definition_mastodon_rails_puma_memory

Memory size for rails_puma ECS task.

default: `300`

### aws_ecs_task_definition_mastodon_rails_sidekiq_memory

Memory size for rails_sidekiq ECS task.

default: `300`

### aws_elasticache_cluster_node_type

AWS Elasticache Cluster node type.

default: `cache.t2.micro`

FYI: https://aws.amazon.com/jp/elasticache/pricing/.

### aws_launch_configuration_mastodon_instance_type

AWS EC2 instance type.

default: `t2.micro`

FYI: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html.

### mastodon_administrator_name

Administrator user name for the `mastodon_rails_mastodon_make_admin` ECS task.

### mastodon_aws_access_key_id

AWS IAM user access key ID for Rails to access to AWS API.

### mastodon_aws_secret_access_key

AWS IAM user secret access key for Rails to access to AWS API.

### mastodon_db_name

DB name.

default: `mastodon`

### mastodon_db_user

DB user name.

default: `root`

### mastodon_default_locale

Default locale.

default: `en`

### mastodon_email_domain_blacklist

Email domain blacklist.

### mastodon_email_domain_whitelist

Email domain whitelist.

### mastodon_node_streaming_api_base_url

The base URL of Streaming API endpoint.

e.g. `https://mastodon-streaming.example.com:4000`

### mastodon_node_streaming_cluster_num

default: `1`

### mastodon_single_user_mode

Should the instance run in single user mode? (Disable registrations, redirect to front page)

default: `false`

### mastodon_rails_log_level

The logging level for the application. See mastodon docs for details.

### Others

- `mastodon_paperclip_root_path`
- `mastodon_paperclip_root_url`
- `mastodon_paperclip_secret`
- `mastodon_prepared_statements`
- `mastodon_smtp_auth_method`
- `mastodon_smtp_delivery_method`
- `mastodon_smtp_domain`
- `mastodon_smtp_enable_starttls_auto`
- `mastodon_smtp_from_address`
- `mastodon_smtp_login`
- `mastodon_smtp_openssl_verify_mode`
- `mastodon_smtp_port`
- `mastodon_smtp_server`


# Connecting to Mastodon Database Via Baston Host

Create a Keypair in the EC2 Console.  Keep it safe and note the name.

Make sure IP's are whitelisted (see above for proper vars to set)

Add this to ~/.ssh/config:

```
 Host mastodon-bastion
   User ubuntu
   Hostname [bastion host public IP from EC2 console]
   IdentityFile ~/.ssh/[your private key from console]
```

Then `ssh mastodon-bastion`

Find your database's hostname in the RDS console.

You can then connect via an SSH tunnel like this:
(see (this amazon article)[https://aws.amazon.com/premiumsupport/knowledge-center/rds-connect-using-bastion-host-linux/] for more detail):

```sh
ssh -f -N -L 5432:YOURDATABSEHOSTNAMEHERE.rds.amazonaws.com:5432 mastodon-bastion -v
```