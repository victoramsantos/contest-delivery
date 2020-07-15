variable "region" {}

variable "account_id" {}

variable "border_gateway_name" {
  type = string
}

variable "resource" {
  type = string
}

variable "http_method" {
  type = string
}

variable "lambda_invoke_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "stage_name" {
  type = string
}


variable "allow_headers" {
  type        = list(string)

  default = [
    "Authorization",
    "Content-Type",
    "X-Amz-Date",
    "X-Amz-Security-Token",
    "X-Api-Key",
  ]
}

variable "allow_methods" {
  type        = list(string)

  default = [
    "OPTIONS",
    "POST"
  ]
}