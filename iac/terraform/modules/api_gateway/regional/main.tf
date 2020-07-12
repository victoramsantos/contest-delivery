resource "aws_api_gateway_rest_api" "api" {
  name = var.api_gtw_name

  tags = {
    type = "border_gateway"
  }
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}