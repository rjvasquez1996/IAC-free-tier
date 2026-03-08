resource "aws_apigatewayv2_integration" "roulette" {
  api_id                 = var.api_id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.roulette.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "list_users" {
  api_id    = var.api_id
  route_key = "GET /roulette/users"
  target    = "integrations/${aws_apigatewayv2_integration.roulette.id}"
}

resource "aws_apigatewayv2_route" "register_user" {
  api_id    = var.api_id
  route_key = "POST /roulette/users"
  target    = "integrations/${aws_apigatewayv2_integration.roulette.id}"
}

resource "aws_apigatewayv2_route" "deregister_user" {
  api_id    = var.api_id
  route_key = "DELETE /roulette/users/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.roulette.id}"
}

resource "aws_apigatewayv2_route" "pick_winner" {
  api_id    = var.api_id
  route_key = "POST /roulette/pick"
  target    = "integrations/${aws_apigatewayv2_integration.roulette.id}"
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.roulette.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_execution_arn}/*/*"
}
