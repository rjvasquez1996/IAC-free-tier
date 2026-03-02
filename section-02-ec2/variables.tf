variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "mx-central-1"
}

variable "instance_type" {
  description = "EC2 instance type (t2.micro is free-tier eligible)"
  type        = string
  default     = "t2.micro"
}
