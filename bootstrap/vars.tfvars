api_gtw_name = "border_gateway"
lambda_handler = "index.handler"
lambda_name = "authenticator"
lambda_runtime = "nodejs12.x"
lambda_zip_path = "lambda/lambda.zip"
cidr = "0.0.0.0/0"
db_sg_name = "mysql-sg"
port = 3306
vpc_id = "vpc-0e23f528e453cccaf"
db_subnet_group_name = "db-subnet-group"
subnet_ids = ["subnet-046e132a154013a23", "subnet-0904417ba74686a79"]
sg_name = "all-traffic-sg"
key_name = "nova-pem"
name_prefix = "jumpbox"

