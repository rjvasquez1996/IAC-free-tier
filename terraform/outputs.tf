output "app_address" {
  description = "Application URL for the EC2 instance"
  value       = var.enabled_sections.section02 ? "http://${module.ec2[0].public_ip}:5230" : null
}

output "website_url" {
  description = "CloudFront URL for the static website"
  value       = var.enabled_sections.section03 ? "https://${module.s3_website[0].cloudfront_domain_name}" : null
}

output "website_bucket" {
  description = "S3 bucket name for the static website"
  value       = var.enabled_sections.section03 ? module.s3_website[0].bucket_name : null
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID (use this to invalidate the cache)"
  value       = var.enabled_sections.section03 ? module.s3_website[0].cloudfront_distribution_id : null
}

output "api_endpoint" {
  description = "HTTP API Gateway base URL (call /hello to test)"
  value       = var.enabled_sections.section04 ? module.api_gateway[0].api_endpoint : null
}