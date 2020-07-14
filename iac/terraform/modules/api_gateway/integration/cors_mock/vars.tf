
variable "border_gateway_name" {
  type = string
}

variable "resource" {
  type = string
}

variable "stage_name" {
  type = string
}

variable "region" {}

variable "account_id" {}
variable "http_method" {
  type = string
}

variable "lambda_invoke_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}
