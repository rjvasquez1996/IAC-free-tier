
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = var.run_on_ecs ? aws_instance.ecs_container_instance[0].id : aws_instance.free_tier[0].id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = var.run_on_ecs ? aws_instance.ecs_container_instance[0].public_ip : aws_instance.free_tier[0].public_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = var.run_on_ecs ? aws_instance.ecs_container_instance[0].public_dns : aws_instance.free_tier[0].public_dns
}
