# source: https://minhajuddin.com/2020/05/06/how-to-create-temporary-bastion-ec2-instances-using-terraform/

variable "bastion_ssh_key_name" {
  description = "Name of AWS key pair"
}

variable "bastion_cidrs" {
  type        = string
  description = "Comma separated list of CIDR blocks to allow SSH access into the bastion server."
}

variable "bastion_enabled" {
  description = "Spins up a bastion host if enabled"
  type        = bool
}

# Allows SSH connections from bastion to database
resource "aws_security_group" "mastodon_bastion_db_sg" {

  # We use a variable which can be set to true or false in the terraform.tfvars
  # file to control creating or destroying the bastion resource on demand.
  count = var.bastion_enabled ? 1 : 0
  name   = "mastodon_bastion_db_sg"
  vpc_id = aws_vpc.mastodon.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [ "${aws_instance.bastion[0].private_ip}/32" ] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# private IP to bastion
resource "aws_security_group" "mastodon_bastion_sg" {

  # We use a variable which can be set to true or false in the terraform.tfvars
  # file to control creating or destroying the bastion resource on demand.
  count = var.bastion_enabled ? 1 : 0
  name   = "hn_bastion_sg"
  vpc_id = aws_vpc.mastodon.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # TODO is this right to do?
    cidr_blocks = var.bastion_enabled ? split(",", var.bastion_cidrs) : ["9.9.9.9/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Allow inter security group connections
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.mastodon.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# get a reference to aws_ami.id using a data resource by finding the right AMI
data "aws_ami" "ubuntu" {
  # pick the most recent version of the AMI
  most_recent = true

  # Find the 20.04 image
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  # With the right virtualization type
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # And the image should be published by Canonical (which is a trusted source)
  owners = ["099720109477"] # Canonical's owner_id don't change this
}

# Configuration for your bastion EC2 instance
resource "aws_instance" "bastion" {
  # Use the AMI from the above step
  ami = data.aws_ami.ubuntu.id

  # We don't need a heavy duty server, t2.micro should suffice
  instance_type = "t2.micro"

  # We use a variable which can be set to true or false in the terraform.tfvars
  # file to control creating or destroying the bastion resource on demand.
  count = var.bastion_enabled ? 1 : 0

  # The ssh key name
  key_name = var.bastion_ssh_key_name

  # This should refer to the subnet in which you want to spin up the Bastion host
  # You can even hardcode this ID by getting a subnet id from the AWS console
  subnet_id = aws_subnet.mastodon_public_a.id

  # The 2 security groups here have 2 important rules
  # 1. hn_bastion_sg: opens up Port 22 for just my IP address
  # 2. default: sets up an open network within the security group
  vpc_security_group_ids = [aws_security_group.mastodon_bastion_sg[0].id, 
    aws_default_security_group.default.id ]

  # Since we want to access this via internet, we need a public IP
  associate_public_ip_address = true

  # Some useful tags
  tags = {
    Name = "Bastion"
  }
}

# We want to output the public_dns name of the bastion host when it spins up
output "bastion-public-dns" {
  value = var.bastion_enabled ? aws_instance.bastion[0].public_dns : "No-bastion"
}