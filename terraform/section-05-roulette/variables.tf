variable "api_name" {
  description = "Name prefix for resources"
  type        = string
}

variable "api_id" {
  description = "ID of the existing API Gateway from section 04"
  type        = string
}

variable "api_execution_arn" {
  description = "Execution ARN of the existing API Gateway from section 04"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for uploading the frontend HTML"
  type        = string
}
