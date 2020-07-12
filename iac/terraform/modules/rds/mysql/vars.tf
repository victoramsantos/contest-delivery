# RDS - Mysql
variable "allocated_storage" {
  default = 20
}
variable "storage_type" {
  default = "gp2"
}
variable "engine" {
  default = "mysql"
}
variable "engine_version" {
  default = "5.7"
}
variable "instance_class" {
  default = "db.t2.micro"
}
variable "identifier" {
  type = string
}
variable "parameter_group_name" {
  default = "default.mysql5.7"
}

variable "db_subnet_group_name" {
  type = string
}
#Data: Security Group
variable "db_sg_name" {
  type = string
}