resource "aws_dynamodb_table" "roulette_users" {
  name         = "${var.api_name}-roulette-users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "${var.api_name}-roulette-users"
  }
}
