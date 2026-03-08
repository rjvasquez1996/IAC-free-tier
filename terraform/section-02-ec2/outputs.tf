output "key_pair_name" {
  description = "Name of the AWS key pair created for SSH access"
  value       = aws_key_pair.ec2.key_name
}

output "private_key_path" {
  description = "Path to the private key file for SSH access"
  value       = local_sensitive_file.private_key.filename
}

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
