variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "mx-central-1"
}

variable "budget_limit_usd" {
  description = "Monthly budget limit in USD"
  type        = string
  default     = "1.0"
}

variable "alert_email" {
  description = "Email address to receive budget alert notifications"
  type        = string
  sensitive   = true
}
variable "instance_type" {
  description = "EC2 instance type (t2.micro is free-tier eligible)"
  type        = string
  default     = "t2.micro"
}

variable "s3_bucket_name" {
  description = "Globally unique name for the S3 static website bucket"
  type        = string
}

variable "index_document" {
  description = "HTML file served as the website root"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "HTML file served on 4xx errors"
  type        = string
  default     = "error.html"
}

variable "api_name" {
  description = "Name prefix for the API Gateway and related Lambda resources"
  type        = string
  default     = "my-api"
}

variable "api_allowed_origins" {
  description = "CORS allowed origins for the API Gateway (e.g. your CloudFront domain)"
  type        = list(string)
  default     = ["*"]
}

variable "enabled_sections" {
  description = "sections in where we call the module"
  default = {
    section01 = true
    section02 = true
    section03 = true
    section04 = true
  }
}