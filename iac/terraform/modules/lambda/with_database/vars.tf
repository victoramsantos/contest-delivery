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

variable "database_identifier" {
  type = string
}

variable "secret_username_arn" {
  type = string
}
variable "secret_password_arn" {
  type = string
}

variable "subnet_ids" {
  type = list
}
variable "sg_ids" {
  type = list
}

variable "database_name" {
  type = string
}