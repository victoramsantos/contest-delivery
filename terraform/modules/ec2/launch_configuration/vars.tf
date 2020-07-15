variable "name_prefix" {}
variable "security_groups" {}
variable "instance_type" {}
variable "key_name" {}

variable "ami_id" {
  type = string
  default = "ami-09d95fab7fff3776c"
}
