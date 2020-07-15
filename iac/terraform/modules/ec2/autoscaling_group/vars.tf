variable "name_prefix" {}
variable "launch_configuration_name" {}
variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 1
}
variable "vpc_zone_identifier" {}
