variable "region" {}

variable "account_id" {}

variable "border_gateway_name" {
  type = string
  default = "border_gateway"
}

variable "resource" {
  type = string
}

variable "stage_name" {
  type = string
}

variable "http_method" {
  type = string
}

variable "lambda_zip_path" {
  type = string
}

variable "lambda_name" {
  type = string
}

variable "lambda_runtime" {
  type = string
}

variable "lambda_handler" {
  type = string
}
