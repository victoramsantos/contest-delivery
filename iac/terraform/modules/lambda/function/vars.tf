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

variable "environment" {
  type = map(string)
  default = {}
}