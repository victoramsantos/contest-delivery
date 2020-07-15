resource "aws_launch_configuration" "lifecycle_lc" {
  name = var.name_prefix
  key_name = var.key_name
  image_id = var.ami_id
  instance_type = var.instance_type
  security_groups = var.security_groups

  lifecycle {
    create_before_destroy = true
  }
}