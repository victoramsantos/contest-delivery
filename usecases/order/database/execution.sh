#!/bin/bash

STACK_PATH=../../../terraform/stacks/database/rds/mysql

terraform init $STACK_PATH

terraform apply -var-file=vars.tfvars --auto-approve $STACK_PATH
#terraform destroy -var-file=vars.tfvars --auto-approve $STACK_PATH
