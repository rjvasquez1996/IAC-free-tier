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

variable "enabled_sections" {
  description = "sections in where we call the module"
  default = {
    section01 = true
    section02 = true
  }
}