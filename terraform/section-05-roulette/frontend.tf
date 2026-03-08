data "aws_apigatewayv2_api" "this" {
  api_id = var.api_id
}

resource "aws_s3_object" "roulette_html" {
  bucket       = var.s3_bucket_name
  key          = "roulette.html"
  content_type = "text/html"

  content = templatefile("${path.module}/roulette.html", {
    api_url = "${data.aws_apigatewayv2_api.this.api_endpoint}/roulette"
  })
}
