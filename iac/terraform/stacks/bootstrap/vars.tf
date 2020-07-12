variable "api_gtw_name" {
  default = "border_gateway"
}

variable "db_sg_cidr" {
  default = "0.0.0.0/0"
}

variable "mysql_sg_name" {
  default = "mysql-sg"
}

variable "vpc_id" {
  default = "vpc-0e23f528e453cccaf"
}

variable "mysql_port" {
  default = 3306
}

variable "subnet_ids" {
  default = ["subnet-046e132a154013a23", "subnet-0904417ba74686a79"]
}
variable "db_subnet_group_name" {
  default = "db-subnet-group"
}

variable "all_traffic_sg_name" {
  default = "all-traffic-sg"
}