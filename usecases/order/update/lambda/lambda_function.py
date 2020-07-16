import json
import boto3
import os
import pymysql

from botocore.exceptions import ClientError

def get_secret(secret_name):
    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
        return get_secret_value_response['SecretString']
    except ClientError as e:
        print(f"Error: {e.response['Error']['Code']}")
        raise e
    except Exception as e:
        print(f"Unexpected Error: {str(e)}")
        raise e


def db_connection(hostname, username, password, database):
    try:
        return pymysql.connect(hostname, user=username, passwd=password, db=database, connect_timeout=3)
    except Exception as e:
        print(str(e))
        raise e

def update_product(product, conn):
    id = product["id"]
    price = product["price"]
    name = product["name"]

    query = f"update products set name = '{name}', price = {price} where id = {id}"
    with conn.cursor() as cur:
        cur.execute(query)

def lambda_handler(event, context):
    body = event
    conn = db_connection(hostname, username, password, database)

    product = body["product"]
    print(product)
    product = update_product(product, conn)

    return {
        'statusCode': 200,
        'body': json.dumps({
            "status": True
        })
    }


region_name = "us-east-1"

session = boto3.session.Session()
client = session.client(
    service_name='secretsmanager',
    region_name=region_name
)

hostname = os.getenv("DATABASE_ADDRESS")
database = os.getenv("DATABASE_NAME")
username = get_secret("contest-database-username")
password = get_secret("contest-database-password")