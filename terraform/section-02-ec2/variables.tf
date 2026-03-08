variable "instance_type" {
  description = "EC2 instance type (t2.micro is free-tier eligible)"
  type        = string
  default     = "t2.micro"
}
variable "ami_id" {
  description = "id of the EC2 ami"
  type        = string
}

variable "ssh_whitelist" {
  description = "Static list of CIDRs allowed SSH access. If empty, the current public IP is used automatically."
  type        = list(string)
  default     = []
}