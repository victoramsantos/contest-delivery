STACK_PATH=../../terraform/stacks/static_site

terraform init $STACK_PATH

terraform apply -var-file=vars.tfvars --auto-approve $STACK_PATH
#terraform destroy -var-file=vars.tfvars --auto-approve $STACK_PATH
#terraform plan -var-file=vars.tfvars $STACK_PATH
