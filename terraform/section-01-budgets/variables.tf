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
