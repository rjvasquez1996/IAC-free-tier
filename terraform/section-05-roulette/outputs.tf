output "dynamodb_table_name" {
  description = "Name of the roulette DynamoDB table"
  value       = aws_dynamodb_table.roulette_users.name
}

output "lambda_function_name" {
  description = "Name of the roulette Lambda function"
  value       = aws_lambda_function.roulette.function_name
}
