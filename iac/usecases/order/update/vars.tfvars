#api_lambda_integraion
account_id = "965813040839"
http_method = "POST"
lambda_handler = "lambda_function.lambda_handler"
lambda_name = "order_update"
lambda_runtime = "python3.8"
lambda_zip_path = "lambda.zip"
region = "us-east-1"
resource = "updateOrder"
stage_name = "developer"
database_identifier = "order-db"
mysql_sg_name = "mysql-sg"
all_traffic_sg_name = "all-traffic-sg"
subnet_ids = ["subnet-046e132a154013a23", "subnet-0904417ba74686a79"]
secret_password_arn = "arn:aws:secretsmanager:us-east-1:965813040839:secret:order-db-password-6Q52bl"
secret_username_arn = "arn:aws:secretsmanager:us-east-1:965813040839:secret:order-db-username-wKj0ki"
database_name = "delivery"