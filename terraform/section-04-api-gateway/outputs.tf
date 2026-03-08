output "api_endpoint" {
  description = "Base URL of the HTTP API (e.g. https://xxx.execute-api.region.amazonaws.com)"
  value       = aws_apigatewayv2_stage.default.invoke_url
}

output "api_id" {
  description = "ID of the HTTP API Gateway"
  value       = aws_apigatewayv2_api.this.id
}

output "api_execution_arn" {
  description = "Execution ARN of the HTTP API Gateway"
  value       = aws_apigatewayv2_api.this.execution_arn
}
