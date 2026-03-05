output "api_endpoint" {
  description = "Base URL of the HTTP API (e.g. https://xxx.execute-api.region.amazonaws.com)"
  value       = aws_apigatewayv2_stage.default.invoke_url
}

output "lambda_function_name" {
  description = "Name of the placeholder Lambda function"
  value       = aws_lambda_function.api.function_name
}
