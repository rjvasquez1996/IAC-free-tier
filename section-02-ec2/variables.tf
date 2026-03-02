variable "instance_type" {
  description = "EC2 instance type (t2.micro is free-tier eligible)"
  type        = string
  default     = "t2.micro"
}
variable "ami_id" {
  description = "id of the EC2 ami"
  type        = string
}