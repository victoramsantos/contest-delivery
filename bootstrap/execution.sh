#!/bin/bash

STACK_PATH=../../../terraform/stacks/bootstrap

rm lambda.zip

cd lambda

zip -r lambda.zip .

mv lambda.zip ../

cd ..

terraform init $STACK_PATH

terraform apply -var-file=vars.tfvars --auto-approve $STACK_PATH
#terraform destroy -var-file=vars.tfvars --auto-approve $STACK_PATH
#terraform plan -var-file=vars.tfvars $STACK_PATH
