variable "api_name" {
  description = "Name prefix for the API Gateway and related Lambda resources"
  type        = string
}

variable "allowed_origins" {
  description = "CORS allowed origins (e.g. your CloudFront domain: https://xxx.cloudfront.net)"
  type        = list(string)
  default     = ["*"]
}
