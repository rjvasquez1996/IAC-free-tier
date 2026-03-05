variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
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
