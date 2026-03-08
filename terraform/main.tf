provider "aws" {
  region = var.aws_region
}

# Fetch the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-ecs-hvm-2023.0.20260226-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "budgets" {
  count            = var.enabled_sections.section01 ? 1 : 0
  source           = "./section-01-budgets"
  alert_email      = var.alert_email
  budget_limit_usd = var.budget_limit_usd
}

module "ec2" {
  count         = var.enabled_sections.section02 ? 1 : 0
  source        = "./section-02-ec2"
  instance_type = var.instance_type
  ami_id        = data.aws_ami.amazon_linux_2023.id
}

module "s3_website" {
  count          = var.enabled_sections.section03 ? 1 : 0
  source         = "./section-03-s3-cloudfront"
  bucket_name    = var.s3_bucket_name
  index_document = var.index_document
  error_document = var.error_document
}

module "api_gateway" {
  count           = var.enabled_sections.section04 ? 1 : 0
  source          = "./section-04-api-gateway"
  api_name        = var.api_name
  allowed_origins = ["https://${module.s3_website[0].cloudfront_domain_name}"]
}