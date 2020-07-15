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

variable "secret_username_arn" {
  type = string
}

variable "secret_password_arn" {
  type = string
}

variable "database_identifier" {
  type = string
}

variable "database_name" {
  type = string
}

variable "mysql_sg_name" {
  type = string
}

variable "all_traffic_sg_name" {
  type = string
}

variable "subnet_ids" {
  type = list
}

variable "lambda_authorization_name" {
  type = string
}