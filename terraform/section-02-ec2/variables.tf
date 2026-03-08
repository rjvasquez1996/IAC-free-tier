variable "instance_type" {
  description = "EC2 instance type (t2.micro is free-tier eligible)"
  type        = string
  default     = "t2.micro"
}
variable "ami_id" {
  description = "id of the EC2 ami"
  type        = string
}

variable "run_on_ecs" {
  description = "If true, runs the application on an ECS cluster (EC2 launch type). If false, runs directly on a standalone EC2 instance with Docker. Only one mode is active at a time."
  type        = bool
  default     = false
}